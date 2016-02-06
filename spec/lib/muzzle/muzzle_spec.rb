require 'spec_helper'

describe Muzzle::Muzzle do
  let(:clasp_repo) { FakeClaspRepo.new }
  let(:muzzle) { described_class.new(clasp_repo: clasp_repo) }

  describe '#clasped?' do
    it 'is not worn by default' do
      expect(muzzle).not_to be_clasped
    end

    it 'can be put on and taken off' do
      muzzle.clasp
      expect(muzzle).to be_clasped

      muzzle.unclasp
      expect(muzzle).not_to be_clasped
    end
  end

  describe '#clasp' do
    it 'can have a loose fit for falling off later' do
      muzzle.clasp(clasped_until: Time.zone.now + 30.minutes)
      expect(muzzle).to be_clasped

      muzzle.unclasp
      muzzle.clasp(clasped_until: Time.zone.now - 30.minutes)
      expect(muzzle).not_to be_clasped
    end

    it 'only considers the most recent clasp' do
      muzzle.clasp(clasped_until: Time.zone.now - 30.minutes)
      muzzle.unclasp
      muzzle.clasp
      expect(muzzle).to be_clasped
    end
  end
end

RSpec::Matchers.define :be_clasped do
  match(&:clasped?)

  failure_message do |muzzle|
    "expected that #{muzzle} would be clasped"
  end

  failure_message_when_negated do |muzzle|
    "expected that #{muzzle} would not be clasped"
  end
end

class FakeClaspRepo
  def initialize
    @clasps = []
  end

  def save(clasp)
    @clasps << clasp
  end

  def find_by_most_recent
    @clasps.last
  end
end

def clasp_repo_contract(clasp_repo)
  describe 'clasp repo' do
    it 'finds by most recent clasp' do
      closed_clasp = Muzzle::Clasp.new
      loose_clasp = Muzzle::LooseClasp.new(Time.zone.now)
      empty_clasp =  Muzzle::EmptyClasp.new

      clasp_repo.save(closed_clasp)
      clasp_repo.save(loose_clasp)
      clasp_repo.save(empty_clasp)

      expect(clasp_repo.find_by_most_recent.enabled?).to eq false
    end

    it 'keeps track of expired clasps' do
      loose_clasp = Muzzle::LooseClasp.new(Time.zone.now - 30.minutes)
      clasp_repo.save(loose_clasp)
      expect(clasp_repo.find_by_most_recent.enabled?).to eq false
    end

    it 'keeps tracks of clasps that will expire in the future' do
      loose_clasp = Muzzle::LooseClasp.new(Time.zone.now + 30.minutes)
      clasp_repo.save(loose_clasp)
      expect(clasp_repo.find_by_most_recent.enabled?).to eq true
    end
  end
end

clasp_repo_contract(FakeClaspRepo.new)

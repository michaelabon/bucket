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
      muzzle.clasp(falls_off_at: Time.zone.now + 30.minutes)
      expect(muzzle).to be_clasped

      muzzle.unclasp
      muzzle.clasp(falls_off_at: Time.zone.now - 30.minutes)
      expect(muzzle).not_to be_clasped
    end

    it 'only considers the most recent clasp' do
      muzzle.clasp(falls_off_at: Time.zone.now - 30.minutes)
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

require_relative './clasp_repo_contract'
require_relative './fake_clasp_repo'

clasp_repo_contract(FakeClaspRepo.new)

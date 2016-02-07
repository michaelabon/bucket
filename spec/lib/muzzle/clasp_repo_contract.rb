def clasp_repo_contract(clasp_repo)
  describe 'clasp repo' do
    it 'finds by most recent clasp' do
      closed_clasp = Muzzle::Clasp.new
      loose_clasp = Muzzle::LooseClasp.new(Time.zone.now)
      empty_clasp = Muzzle::EmptyClasp.new

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

    it 'removes all history of clasps' do
      clasp = Muzzle::Clasp.new
      clasp_repo.save(clasp)
      clasp_repo.delete_all
      expect(clasp_repo.find_by_most_recent).to eq nil
    end
  end
end

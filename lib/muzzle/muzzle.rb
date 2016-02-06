module Muzzle
  class Muzzle
    def initialize(clasp_repo:)
      @clasp_repo = clasp_repo
    end

    def clasped?
      clasp = @clasp_repo.find_by_most_recent || EmptyClasp.new
      clasp.enabled?
    end

    def clasp(clasped_until: nil)
      clasp = clasped_until ? LooseClasp.new(clasped_until) : Clasp.new
      @clasp_repo.save(clasp)
    end

    def unclasp
      clasp = EmptyClasp.new
      @clasp_repo.save(clasp)
    end
  end

  class EmptyClasp
    def enabled?
      false
    end
  end

  class Clasp
    def enabled?
      true
    end
  end

  class LooseClasp
    def initialize(expiration_date)
      @expiration_date = expiration_date
    end

    def enabled?
      !(Time.zone.now > @expiration_date)
    end
  end
end

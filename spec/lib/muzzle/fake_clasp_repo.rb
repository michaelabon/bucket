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

  def delete_all
    @clasps = []
  end
end

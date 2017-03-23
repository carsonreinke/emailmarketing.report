class ReportString < Report
  validates :string, {:presence => true}

  def value(); self.string; end
  def value=(v); self.string = v; end
end

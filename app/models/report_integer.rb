class ReportInteger < Report
  validates :integer, {:numericality => {:only_integer => true}}

  def value(); self.integer; end
  def value=(v); self.integer = v; end
end

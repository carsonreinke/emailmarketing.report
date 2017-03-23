class ReportDecimal < Report
  validates :decimal, {:numericality => true}

  def value(); self.decimal; end
  def value=(v); self.decimal = v; end
end

module RootHelper
  def chart(key)
    obj = @charts[key]
    return nil if obj.nil?()

    content_tag(:canvas, nil, {:'data-chart' => obj.configuration.to_json()})
  end
end

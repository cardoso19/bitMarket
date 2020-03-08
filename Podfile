platform :ios, '13.2'
workspace 'BitMarket'
use_frameworks!

target 'BitMarket' do
  project 'BitMarket.project'

  # pod "Currency", :path => "Currency"

  target 'BitMarketTests' do
    inherit! :search_paths
  end
end

target 'Currency' do
  project 'Currency/Currency.project'

  # pod "Formatter", :path => "Formatter"
  # pod "Resources", :path => "Resources"
  # pod "Service", :path => "Service"

  target 'CurrencyTests' do
    inherit! :search_paths
  end
end

target 'Formatter' do
  project 'Formatter/Formatter.project'

  target 'FormatterTests' do
    inherit! :search_paths
  end
end

target 'Resources' do
  project 'Resources/Resources.project'

  target 'ResourcesTests' do
    inherit! :search_paths
  end
end

target 'Service' do
  project 'Service/Service.project'

  # pod "Formatter", :path => "Formatter"

  target 'ServiceTests' do
    inherit! :search_paths
  end
end

workspace 'BitMarket.xcworkspace'

target 'Bit Market' do
  project 'BitMarket.project'
  use_frameworks!

  target 'Bit MarketTests' do
    inherit! :search_paths
  end

  target 'Currency' do
    project 'Currency/Currency.project'
  
    target 'CurrencyTests' do
      inherit! :search_paths
    end
  end

  target 'Service' do
    project 'Service/Service.project'
  
    target 'ServiceTests' do
      inherit! :search_paths
    end
  end

  target 'Resources' do
    project 'Resources/Resources.project'
  
    target 'ResourcesTests' do
      inherit! :search_paths
    end
  end

  target 'Formatter' do
    project 'Formatter/Formatter.project'
  
    target 'FormatterTests' do
      inherit! :search_paths
    end
  end

end

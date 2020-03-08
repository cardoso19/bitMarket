Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name = "Currency"
  spec.version = "0.0.1"
  spec.summary = "Contains the currency's flow."
  spec.license = "MIT"
  spec.homepage = "http://EXAMPLE/Currency"
  
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author = { "Matheus Kuhn" => "matheuscardosokuhn@hotmail.com" }
  
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform = :ios, "13.2"
  spec.swift_version = "5.0"
  
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source = { :path => "." }
  
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files = "Currency"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # spec.dependency "Formatter", :path => "../Formatter"
  # spec.dependency "Resources", :path => "../Resources"
  # spec.dependency "Service", :path => "../Service"
  
end
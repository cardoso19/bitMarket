Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name = "Service"
  spec.version = "0.0.1"
  spec.summary = "Constains the network layer and models."
  spec.license = "MIT"
  spec.homepage = "http://EXAMPLE/Service"
  
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author = { "Matheus Kuhn" => "matheuscardosokuhn@hotmail.com" }
  
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform = :ios, "13.2"
  spec.swift_version = "5.0"
  
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source = { :path => "." }
  
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files = "Service"
  
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # spec.dependency "Formatter", :path => "../Formatter"

end
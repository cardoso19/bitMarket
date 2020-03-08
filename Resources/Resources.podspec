Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name = "Resources"
  spec.version = "0.0.1"
  spec.summary = "Constains resources files, colors, assets."
  spec.license = "MIT"
  spec.homepage = "http://EXAMPLE/Resources"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author             = { "Matheus Kuhn" => "matheuscardosokuhn@hotmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform = :ios, "13.2"
  spec.swift_version = "5.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source = { :path => "." }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files = "Resources"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.resources = "Resources/**/*.{xcassets}"

end

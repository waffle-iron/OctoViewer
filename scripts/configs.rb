DEBUG_CLIENT_ID = 'yourIDhere'.freeze
DEBUG_SECRET = 'yoursecrethere'.freeze
PRODUCTION_CLIENT_ID = 'yourIDhere'.freeze
PRODUCTION_SECRET = 'yoursecrethere'.freeze

File.open('Debug.xcconfig', 'w') do |f|
  f.write("#include \"Pods/Target Support Files/Pods-OctoViewer/Pods-OctoViewer.debug.xcconfig\"\n")
  f.write("CLIENT_ID = #{DEBUG_CLIENT_ID}\n")
  f.write("CLIENT_SECRET = #{DEBUG_SECRET}\n")
end

File.open('Production.xcconfig', 'w') do |f|
  f.write("#include \"Pods/Target Support Files/Pods-OctoViewer/Pods-OctoViewer.release.xcconfig\"\n")
  f.write("CLIENT_ID = #{PRODUCTION_CLIENT_ID}\n")
  f.write("CLIENT_SECRET = #{PRODUCTION_SECRET}\n")
end

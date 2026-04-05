# محتوى ملف podhelper.rb القياسي لـ Flutter
def flutter_install_all_ios_pods(ios_application_path = nil)
  flutter_application_path ||= File.join(ios_application_path, '..')
  
  # الحصول على قائمة الإضافات (plugins)
  plugins_file = File.join(flutter_application_path, '.flutter-plugins-dependencies')
  if File.exist?(plugins_file)
    require 'json'
    plugins_config = JSON.parse(File.read(plugins_file))
    plugins_config['plugins']['ios'].each do |plugin|
      pod plugin['name'], :path => File.join(plugin['path'], 'ios')
    end
  end
end

def flutter_additional_ios_build_settings(target)
  return unless target.respond_to?(:build_configurations)
  target.build_configurations.each do |config|
    config.build_settings['ENABLE_BITCODE'] = 'NO'
  end
end

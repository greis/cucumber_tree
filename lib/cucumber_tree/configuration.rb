class Cucumber::Cli::Configuration
  alias __cucumber_orig_feature_files__ feature_files

  def feature_files
    files = __cucumber_orig_feature_files__
    missing_files = []

    files.each do |file|
      (file.count('/') - 1).times do
        file = file.gsub(/\A(.*)\/.*(\.feature)(:\d+)?\z/, '\1\2')
        missing_files << file if File.file?(file)
      end
    end

    (missing_files + files).uniq.sort!
  end
end

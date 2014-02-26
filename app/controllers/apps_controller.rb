class AppsController < ApplicationController

  attr_accessor :apps_dir

  def initialize
    @apps_dir = Rails.root.join('public','apps')
    FileUtils.mkdir_p(@apps_dir)
    super
  end

  def list
    @app_names = Dir.entries(@apps_dir).select { |entry| File.directory?(File.join(@apps_dir, entry)) and not entry.eql?('.') and not entry.eql?('..')}
  end

  def show_versions
    app_name = params[:app_name]
    plists = app_plists(app_name)

    all_versions = plists.collect do |plist| 
      version_parts = plist["CFBundleVersion"].split('.')
      version_parts[0...-1].join('.')
    end

    @versions = all_versions.uniq

  end

  def file_list(dir)
    Dir.glob("#{dir}/**/*").reject { |entry| !entry.upcase.end_with?('IPA') }
  end

  def app_names(root_dir)
    everything = all_plists(root_dir).collect do |plist|
      plist["CFBundleDisplayName"]
    end
    everything.uniq
  end

  def app_plists(app_name)
    all_plists(@apps_dir).select do |plist|
      app_name.eql?(plist["CFBundleDisplayName"])
    end
  end

  def all_plists(root_dir)
    plists = file_list(root_dir).collect do |ipa_file|
      plist_info(root_dir.join(ipa_file))
    end
    plists.compact
  end

  def plist_info(ipa_file)
    ipa_info = nil
    begin
      IPA::IPAFile.open(ipa_file) do |ipa| 
        ipa_info = ipa.info
      end
    rescue Zip::ZipError

    end
    ipa_info
  end


end

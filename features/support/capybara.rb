require 'capybara'
require 'selenium-webdriver'

def detect_os
  case RbConfig::CONFIG['host_os']
  when /darwin|mac os/i then :macos
  when /mswin|msys|mingw|cygwin|bccwin|wince|emc/i then :windows
  when /linux/i then :linux
  else :linux
  end
end

def chrome_paths
  {
    linux: [
      '/usr/bin/google-chrome',
      '/usr/bin/google-chrome-stable',
      '/opt/google/chrome/chrome',
      '/usr/bin/chromium',
      '/usr/bin/chromium-browser',
      '/snap/bin/chromium'
    ],
    macos: [
      '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
      '/Applications/Chromium.app/Contents/MacOS/Chromium'
    ],
    windows: [
      'C:/Program Files/Google/Chrome/Application/chrome.exe',
      'C:/Program Files (x86)/Google/Chrome/Application/chrome.exe',
      ENV['LOCALAPPDATA'] ? "#{ENV['LOCALAPPDATA']}/Google/Chrome/Application/chrome.exe" : nil,
      'C:/Program Files/Chromium/Application/chrome.exe'
    ].compact
  }
end

def firefox_paths
  {
    linux: [
      '/usr/bin/firefox',
      '/usr/bin/firefox-esr',
      '/snap/bin/firefox'
    ],
    macos: [
      '/Applications/Firefox.app/Contents/MacOS/firefox'
    ],
    windows: [
      'C:/Program Files/Mozilla Firefox/firefox.exe',
      'C:/Program Files (x86)/Mozilla Firefox/firefox.exe',
      ENV['PROGRAMFILES'] ? "#{ENV['PROGRAMFILES']}/Mozilla Firefox/firefox.exe" : nil
    ].compact
  }
end

def find_chrome
  return ENV['CHROME_BIN'] if ENV['CHROME_BIN'] && File.exist?(ENV['CHROME_BIN'])

  os = detect_os
  paths = chrome_paths[os] || []
  paths.find { |path| path && File.exist?(path) }
end

def find_firefox
  return ENV['FIREFOX_BIN'] if ENV['FIREFOX_BIN'] && File.exist?(ENV['FIREFOX_BIN'])

  os = detect_os
  paths = firefox_paths[os] || []
  paths.find { |path| path && File.exist?(path) }
end

begin
  chrome_bin_path = find_chrome

  if chrome_bin_path.nil?
    raise "Chrome binary not found on system path."
  else
    Capybara.register_driver :chrome_or_default do |app|
      options = Selenium::WebDriver::Chrome::Options.new

      options.add_argument('--headless=new')
      options.add_argument('--disable-gpu')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      options.add_argument('--window-size=1920,1080')
      options.add_argument('--disable-site-isolation-trials')
      options.add_argument('--disable-features=IsolateOrigins,site-per-process')

      options.add_argument('--disable-blink-features=AutomationControlled')
      options.add_argument('--disable-extensions')

      options.binary = chrome_bin_path

      Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
    end

    Capybara.javascript_driver = :chrome_or_default
    puts "Capybara configurado: Usando Chrome Headless (#{detect_os})."
    puts "  Caminho: #{chrome_bin_path}"
  end

rescue StandardError => e
  firefox_bin_path = find_firefox

  if firefox_bin_path
    Capybara.register_driver :chrome_or_default do |app|
      options = Selenium::WebDriver::Firefox::Options.new
      options.add_argument('-headless')

      options.add_preference('dom.webdriver.enabled', false)
      options.add_preference('useAutomationExtension', false)

      options.binary = firefox_bin_path if firefox_bin_path

      Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
    end

    Capybara.javascript_driver = :chrome_or_default
    puts "Capybara configurado: Chrome não encontrado. Usando Firefox Headless (#{detect_os})."
    puts "  Caminho: #{firefox_bin_path}"
  else
    puts "Aviso: Nenhum navegador encontrado nos caminhos padrão."
    puts "Tentando usar Selenium Manager..."

    Capybara.register_driver :chrome_or_default do |app|
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless=new')
      options.add_argument('--disable-gpu')
      options.add_argument('--no-sandbox')

      Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
    end

    Capybara.javascript_driver = :chrome_or_default
  end
end

Capybara.default_max_wait_time = 10

case ENV['BROWSER']&.downcase
  when 'firefox'
    puts "→ Forçando uso do Firefox (via ENV['BROWSER'])"
  when 'chrome'
    puts "→ Forçando uso do Chrome (via ENV['BROWSER'])"
  when nil
    puts "→ Nenhuma variável ENV['BROWSER'] definida. Usando navegador padrão."
  else
    puts "→ Valor de ENV['BROWSER'] desconhecido: #{ENV['BROWSER']}. Usando navegador padrão."
end

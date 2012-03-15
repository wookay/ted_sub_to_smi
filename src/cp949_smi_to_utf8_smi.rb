# cp949_smi_to_utf8_smi.rb
#                               wookay.noh at gmail.com

def cp949_smi_to_utf8_smi cp949_data
  require 'iconv'
  utf8_data = Iconv.iconv('UTF8', 'CP949', cp949_data).join
  utf8_data.gsub(/<STYLE.*<\/STYLE>/m, '')
end

if __FILE__ == $PROGRAM_NAME
  options = ARGV
  overwrite = false
  if options.include? '-f'
    overwrite = true
    options.delete '-f'
  end
  Dir[options.join].each do |filename|
    if File.exist? filename
      f = open(filename)
      cp949_data = f.read 
      f.close
      if overwrite
        utf8_data = cp949_smi_to_utf8_smi(cp949_data) rescue nil
        if nil == utf8_data
        else
          f = open(filename, 'w')
          f.write(utf8_data)
          f.close
        end
      else
        puts cp949_smi_to_utf8_smi(cp949_data) rescue nil
      end
    end
  end
end

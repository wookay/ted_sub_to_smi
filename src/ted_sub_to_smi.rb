# ted_sub_to_smi.rb
#                               wookay.noh at gmail.com

require 'json'

SYNC_OFFSET = 15500
def ted_sub_to_smi json_data
  dict = JSON.parse(json_data)
  smi = <<EOF
<SAMI>
<BODY> 
EOF
  dict['captions'].each do |caption|
    startTime = caption['startTime'].to_i + SYNC_OFFSET
    content = caption['content'] 
    smi.concat <<EOF
<Sync Start=#{startTime}><P Class=KRCC>
#{content}
EOF
  end
  smi
end

if __FILE__ == $PROGRAM_NAME
  ARGV.each do |filename|
    if File.exist? filename
      json_data = open(filename).read
      puts ted_sub_to_smi(json_data) rescue nil
    end
  end
end

# smi_to_srt.rb
#                               wookay.noh at gmail.com

require 'hpricot'
def time_to_hour_min_sec time
  sec = time / 1000.0
  hours = sec.to_i / 3600
  minutes = (sec.to_i - (hours * 3600)) / 60
  seconds = sec - (hours * 3600) - (minutes * 60)
  milliseconds = (sec - sec.to_i) * 1000
  "%02d:%02d:%02d,%03d" % [hours, minutes, seconds, milliseconds]
end

LF = "\n"
LAST_END_OFFSET = 10000
def smi_to_srt smi_data
  doc = Hpricot.parse(smi_data)
  starts = []
  (doc/:sync).each do |sync|
    starts.push sync.attributes['start'].to_f
  end
  ps = []
  (doc/:p).each do |p|
    ps.push p.inner_text.strip
  end
  ary = []
  starts.each_with_index do |start, idx|
    ary.push({:start => start, :content => ps[idx]})
  end
  ary.push({:start => (starts.last + LAST_END_OFFSET),
            :content => ''}) if ary.count > 0
  captions = [] 
  idx = 1
  ary.each_cons(2) do |a,b|
    captions.push <<EOF
#{idx}
#{time_to_hour_min_sec(a[:start])} --> #{time_to_hour_min_sec(b[:start])}
#{a[:content]}
EOF
    idx += 1
  end
  captions.join(LF)
end

if __FILE__ == $PROGRAM_NAME
  ARGV.each do |filename|
    if File.exist? filename
      smi_data = open(filename).read
      puts smi_to_srt(smi_data) rescue nil
    end
  end
end

# encoding: utf-8
require '../src/ted_sub_to_smi'
require 'test/unit'

class TestConvert < Test::Unit::TestCase
  def test_ted_sub_to_smi
    # http://www.ted.com/talks/subtitles/id/799/lang/kor
    smi = ted_sub_to_smi <<EOF
{"captions":[{"content":"저는 제인 맥고니걸이고, 게임 디자이너입니다.","startTime":0,"duration":2000,"startOfParagraph":false},{"content":"10년 동안 온라인 게임을 만들어 왔죠.","startTime":2000,"duration":3000,"startOfParagraph":false}
]}
EOF
    assert_equal <<EOF, smi
<SAMI>
<BODY> 
<Sync Start=15500><P Class=KRCC>
저는 제인 맥고니걸이고, 게임 디자이너입니다.
<Sync Start=17500><P Class=KRCC>
10년 동안 온라인 게임을 만들어 왔죠.
EOF
 end
end

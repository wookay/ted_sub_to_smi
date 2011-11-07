# encoding: utf-8
require '../src/smi_to_srt'
require 'test/unit'

class TestConvert < Test::Unit::TestCase
  def test_smi_to_srt
    smi = <<EOF
<SAMI>
<BODY>
<Sync Start=15500><P Class=KRCC>
I'm Jane McGonigal. I'm a game designer.
<Sync Start=17500><P Class=KRCC>
I've been making games online now for 10 years.
<Sync Start=20500><P Class=KRCC>
And my goal for the next decade
<Sync Start=23500><P Class=KRCC>
is to try to make it as easy
EOF
    assert_equal(<<EOF, smi_to_srt(smi))
1
00:00:15,500 --> 00:00:17,500
I'm Jane McGonigal. I'm a game designer.

2
00:00:17,500 --> 00:00:20,500
I've been making games online now for 10 years.

3
00:00:20,500 --> 00:00:23,500
And my goal for the next decade

4
00:00:23,500 --> 00:00:33,500
is to try to make it as easy
EOF
 end
end

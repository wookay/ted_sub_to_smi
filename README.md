TED subtitle to SMI
===================


Convert TED json to SMI
    $ ruby src/ted_sub_to_smi.rb samples/kor 


Convert SMI to SRT
    $ ruby src/smi_to_srt.rb samples/eng.smi


Convert CP949 SMI to UTF-8 SMI
    $ ruby src/cp949_smi_to_utf8_smi.rb samples/cp949.smi
    $ ./src/cp949_smi_to_utf8_smi.rb -f *.smi

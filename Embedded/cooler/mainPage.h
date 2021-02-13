const char MAIN_page[] PROGMEM = R"====(
    <HTML>
    <TITLE>
    MUNGA INNOVATIONS
    </TITLE>
    <BODY>
    <CENTER>
    <FORM method = "post" action = "/form">
    <TABLE>
    <TR><TD colspan=2><B>IoT BASED HOME AUTOMATION - COOLER</B></TD></TR>
    <TR><TD>Temp : @@TEMP@@ C</TD></TR>
    <TR><TD>Waterlevel :< @@WATERLEVEL@@ </TD></TR>
    <TR><TD>
    ENTER TIMER VALUE IN SECONDS: 
    <INPUT TYPE =NUMBER name="device_timer_value" value="100">
    <BR>
    <INPUT TYPE=SUBMIT VALUE="SUBMIT">  
    </TD></TR>
    <TR><TD>
    <INPUT TYPE=SUBMIT VALUE="deviceON" name=submit>
    <INPUT TYPE=SUBMIT VALUE="deviceOFF" name=submit>
    </TD>
    <TD>@@device@@</TD></TR>
    <TR><TD>
    <INPUT TYPE=SUBMIT VALUE="summerON" name=submit>
    <INPUT TYPE=SUBMIT VALUE="summerOFF" name=submit>
    </TD>
    <TD>@@automode@@</TD></TR>
    <TR><TD>
    <INPUT TYPE=SUBMIT VALUE="winterON" name=submit>
    <INPUT TYPE=SUBMIT VALUE="winterOFF" name=submit>
    </TD>
    <TD>@@speed@@</TD></TR>
    <TR><TD>
    <INPUT TYPE=SUBMIT VALUE="rainyON" name=submit>
    <INPUT TYPE=SUBMIT VALUE="rainyOFF" name=submit>
    </TD></TR>
    </TABLE>
    </FORM>
    </CENTER>
    </BODY>
    </HTML>
    )====";

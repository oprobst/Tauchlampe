0 BEGIN PGM TDK1403-03 Deckel 80 MM 
1 ;
2 ;------------------------
3 ;Deckel 80 mm Durchmesser
4 ;Zeichnung TDK1403-03 v. 12.12.2015
5 ;Material POM-C Werkstoffgruppe 20.0
6 ;------------------------
7 ;
8 BLK FORM 0.1 Z  X-40  Y-40  Z-25
9 BLK FORM 0.2  X+40  Y+40  Z+0
10 ;---------------------------------------
11 ;  Tool number     Tool information
12 ;---------------------------------------
13 ;  TOOL CALL 7     Fraeser D=8
14 ;  TOOL CALL 9     Gewindebohrer M16x1,5
15 ;  TOOL CALL 13    Bohrer D=4,2
16 ;  TOOL CALL 22    Bohrer D=12
17 ;  TOOL CALL 25    Bohrer D=14,5
18 ;  TOOL CALL 28    Gewindebohrer M5
19 ;---------------------------------------
20 ;
21 ;------------------------
22 ;Oberseite bearbeiten
23 ;------------------------
24 ;
25 CALL LBL 1 ;Tasche fraesen
26 CALL LBL 2 ;Loch D=12 bohren
27 CALL LBL 3 ;Kernloch D=14,5 f. M16x1,5 bohren
28 CALL LBL 4 ;Gewinde M16x1,5 schneiden
29 ;
30 ;------------------------
31 ;Unterseite bearbeiten
32 ;------------------------
33 ;
34 L  Z+350 FMAX ;in Wechselstellung fahren
35 L M0 ;Werkstueck drehen
36 CALL LBL 5 ;Kernloch D4,2 f. M5 Gewinde bohren
37 CALL LBL 6 ;Gewinde M5 schneiden
38 L  Z+350 FMAX ;in Ruhestellung fahren
39 L M30 ;Programmende
40 ;
41 ;------------------------
42 ;Unterprogramme
43 ;------------------------
44 ;
45 ;Tasche fraesen
46 ;
47 LBL 1
48 TOOL CALL 7 Z S4100 F350 ;Fraeser D=8
49 CYCL DEF 253 NUTENFRAESEN ~
    Q215=+0    ;BEARBEITUNGS-UMFANG ~
    Q218=+38   ;NUTLAENGE ~
    Q219=+20   ;NUTBREITE ~
    Q368=+0    ;AUFMASS SEITE ~
    Q374=+90   ;DREHLAGE ~
    Q367=+0    ;NUTLAGE ~
    Q207= AUTO ;VORSCHUB FRAESEN ~
    Q351=+1    ;FRAESART ~
    Q201=-17   ;TIEFE ~
    Q202=+4    ;ZUSTELL-TIEFE ~
    Q369=+0    ;AUFMASS TIEFE ~
    Q206= AUTO ;VORSCHUB TIEFENZ. ~
    Q338=+0    ;ZUST. SCHLICHTEN ~
    Q200=+2    ;SICHERHEITS-ABST. ~
    Q203=+0    ;KOOR. OBERFLAECHE ~
    Q204=+50   ;2. SICHERHEITS-ABST. ~
    Q366=+1    ;EINTAUCHEN ~
    Q385=+500  ;VORSCHUB SCHLICHTEN
50 L  X+7.5  Y+0 FMAX M3 ;Positionieren u. Spindel an
51 CYCL CALL M8 ;A-Kuehlung ein. Zyklus starten
52 L  Z+100 FMAX ;mit Eilgang auf Z +100
53 LBL 0
54 ;
55 ;Loch D=12 bohren;
56 ;
57 LBL 2
58 TOOL CALL 22 Z S800 ;Bohrer D=12
59 CYCL DEF 205 UNIVERSAL-TIEFBOHREN ~
    Q200=+2    ;SICHERHEITS-ABST. ~
    Q201=-14   ;TIEFE ~
    Q206=+200  ;VORSCHUB TIEFENZ. ~
    Q202=+5    ;ZUSTELL-TIEFE ~
    Q203=-16   ;KOOR. OBERFLAECHE ~
    Q204=+50   ;2. SICHERHEITS-ABST. ~
    Q212=+0    ;ABNAHMEBETRAG ~
    Q205=+0    ;MIN. ZUSTELL-TIEFE ~
    Q258=+0.2  ;VORHALTEABSTAND OBEN ~
    Q259=+0.2  ;VORHALTEABST. UNTEN ~
    Q257=+0    ;BOHRTIEFE SPANBRUCH ~
    Q256=+0.2  ;RZ BEI SPANBRUCH ~
    Q211=+0    ;VERWEILZEIT UNTEN ~
    Q379=+0    ;STARTPUNKT ~
    Q253=+750  ;VORSCHUB VORPOS.
60 L  X+7.5  Y+0 FMAX M3
61 CYCL CALL M8 ;mit Aussenkuehlung
62 L  Z+100 FMAX
63 LBL 0
64 ;
65 ;Kernloch D=14,5 f. M16x1,5 bohren
66 ;
67 LBL 3
68 TOOL CALL 25 Z S600; Bohrer D=14,5
69 CYCL DEF 205 UNIVERSAL-TIEFBOHREN ~
    Q200=+2    ;SICHERHEITS-ABST. ~
    Q201=-28   ;TIEFE ~
    Q206=+200  ;VORSCHUB TIEFENZ. ~
    Q202=+5    ;ZUSTELL-TIEFE ~
    Q203=+0    ;KOOR. OBERFLAECHE ~
    Q204=+50   ;2. SICHERHEITS-ABST. ~
    Q212=+0    ;ABNAHMEBETRAG ~
    Q205=+0    ;MIN. ZUSTELL-TIEFE ~
    Q258=+0.2  ;VORHALTEABSTAND OBEN ~
    Q259=+0.2  ;VORHALTEABST. UNTEN ~
    Q257=+0    ;BOHRTIEFE SPANBRUCH ~
    Q256=+0.2  ;RZ BEI SPANBRUCH ~
    Q211=+0    ;VERWEILZEIT UNTEN ~
    Q379=+0    ;STARTPUNKT ~
    Q253=+750  ;VORSCHUB VORPOS.
70 L  X-15  Y+0 FMAX M3
71 CYCL CALL M8 ;mit Aussenkuehlung
72 L  Z+100 FMAX
73 LBL 0
74 ;
75 ;Gewinde M16x1,5 schneiden
76 ;
77 LBL 4
78 TOOL CALL 9 Z S50 ;Gewindebohrer M16x1,5
79 CYCL DEF 207 GEW.-BOHREN GS NEU ~
    Q200=+2    ;SICHERHEITS-ABST. ~
    Q201=-30   ;GEWINDETIEFE ~
    Q239=+1.5  ;GEWINDESTEIGUNG ~
    Q203=+0    ;KOOR. OBERFLAECHE ~
    Q204=+50   ;2. SICHERHEITS-ABST.
80 L  X-15  Y+0 FMAX M3
81 CYCL CALL M8 ;mit Aussenkuehlung
82 L  Z+100 FMAX
83 LBL 0
84 ;
85 ;Kernloch D=4,2 f. M5 Gewinde bohren
86 ;
87 LBL 5
88 TOOL CALL 13 Z S2200 ;Bohrer D=4,2
89 CYCL DEF 205 UNIVERSAL-TIEFBOHREN ~
    Q200=+5    ;SICHERHEITS-ABST. ~
    Q201=-18   ;TIEFE ~
    Q206=+100  ;VORSCHUB TIEFENZ. ~
    Q202=+5    ;ZUSTELL-TIEFE ~
    Q203=+25   ;KOOR. OBERFLAECHE ~
    Q204=+50   ;2. SICHERHEITS-ABST. ~
    Q212=+0    ;ABNAHMEBETRAG ~
    Q205=+0    ;MIN. ZUSTELL-TIEFE ~
    Q258=+0.2  ;VORHALTEABSTAND OBEN ~
    Q259=+0.2  ;VORHALTEABST. UNTEN ~
    Q257=+0    ;BOHRTIEFE SPANBRUCH ~
    Q256=+0.2  ;RZ BEI SPANBRUCH ~
    Q211=+0    ;VERWEILZEIT UNTEN ~
    Q379=+0    ;STARTPUNKT ~
    Q253=+750  ;VORSCHUB VORPOS.
90 L  X-8  Y+20 FMAX M3
91 CYCL CALL M8 ;mit Aussenkuehlung
92 L  Z+100 FMAX
93 L  X-8  Y-20 FMAX M3
94 CYCL CALL M8
95 L  Z+100 FMAX
96 LBL 0
97 ;
98 ;Gewinde M5 schneiden
99 ;
100 LBL 6
101 TOOL CALL 28 Z S50 ;Gewindebohrer M5
102 CYCL DEF 207 GEW.-BOHREN GS NEU ~
     Q200=+5    ;SICHERHEITS-ABST. ~
     Q201=-8    ;GEWINDETIEFE ~
     Q239=+0.8  ;GEWINDESTEIGUNG ~
     Q203=+25   ;KOOR. OBERFLAECHE ~
     Q204=+50   ;2. SICHERHEITS-ABST.
103 L  X-8  Y-20 FMAX M3
104 CYCL CALL M8
105 L  Z+100 FMAX
106 L  X-8  Y+20 FMAX M3
107 CYCL CALL M8
108 L  Z+100 FMAX
109 LBL 0
110 END PGM TDK1403-03 Deckel 80 MM
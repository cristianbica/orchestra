# tano


https://js.sentry-cdn.com/c07fff22eb5547ffafb98e9358cedc48.min.js




Rails.logger.silence { Shift.where(tenant_id: 1, closed_at: ..Time.new(2024, 2, 9, 0, 0, 0)).find_each { |s| puts s.id; s.shift_trails.update_all(shift_id: -s.id); s.destroy } }

class CustomerSubscription
  has_many :customer_usage_trails, through: :customer_usages, source: :shift_trail
end

Rails.logger.silence { CustomerSubscription.where(created_at: ..Time.new(2022, 1, 1, 0, 0, 0)).find_each { |cs| puts cs.id; ShiftTrail.where(id: cs.customer_usage_trails.ids).delete_all; CustomerUsage.where(id: cs.customer_usages.ids).delete_all; cs.shift_trail&.delete; cs.delete } };1

CustomerSubscription.group("DATE_TRUNC('month', created_at)").count.transform_keys(&:to_date).sort


Rails.logger.silence { ApplicationRecord.subclasses.select(&:multisearchable?).each { |k| puts k.name; PgSearch::Multisearch.rebuild k } }

- expired label
- limita pe utilizare
-


decebal / id: 16
inchis 17.02 -  23.03
243 abonamente

ids = CustomerSubscription.where(location_id: 16, created_at: ..Date.new(2022, 2, 18).beginning_of_day, minutes: 1.., expires_on: Date.new(2022, 2, 18).beginning_of_day..).ids; ids.size


SELECT "customer_subscriptions"."id" FROM "customer_subscriptions" WHERE "customer_subscriptions"."created_at" <= '2022-02-18 00:00:00' AND "customer_subscriptions"."minutes" >= 1 AND "customer_subscriptions"."expires_on" >= '2022-02-18'


[27112, 27145, 27103, 27119, 27136, 27036, 27072, 27031, 27054, 26883, 26508, 26307, 26702, 27367]


https://tanapp.cbid.ro

mina_augustin@yahoo.com
q3s7BtO5um1J

augustin27@yahoo.com
VpS9JFKU8FIr

alexandra@sunfactory.ro
Cosmos33-Wages59

sabina@sunfactory.ro
Expansion31-Herself17


Dr Taberei - verificat stocuri, preturi, contoare, cash de ieri

https://tanapp.cbid.ro


iulia@sunfactory.ro
Trench3-Ravioli3

mihaela@sunfactory.ro
Expansion3-Wages1


```ruby
require 'open-uri'
data = JSON.parse(URI.open("https://gist.githubusercontent.com/cristianbica/18f3afe86273caf3ca850f1a07ecad06/raw/ca6d544bb93b5c4939dbf89e94456ad6821e2926/x.json").read)
l = Location.find(26)
data.each do |r|
  p = Product.find_by(tenant_id: 2, name: r["name"]) || Product.create!(tenant_id: 2, name: r["name"], price: r["price"], availability: "all_locations", skip_fill_location_products_job: true)
  lp = p.location_products.find_by(location_id: l.id, tenant_id: 2) || p.location_products.create!(location_id: l.id, tenant_id: 2, stock: 0)
  lp.update(stock: r["stock"])
end
FillLocationProductsJob.perform_now
```

https://tantastic.cbid.ro/

radu@tantastic.ro
B205n9XVvLEDIoL6

bogdan@tantastic.ro
sheikh2comrade4approval

dan@tantastic.ro
pfFwDNMdBKTdSgGd

simona@tantastic.ro
Upload-Dividing6


https://tantastic.cbid.ro/
ionut@tantastic.ro
WKp70jiBxPoCojS2

Bragadiru
=========

simona+op@tantastic.ro
Sector-Vacant8

bragadiru+guest@tantastic.ro
Curfew-Unpaid8

adriana.costache@tantastic.ro
Step1-Landslide

Alexandra Articuci
alexandra.articuci@tantastic.ro
Equator5-Jump12


Militari Residence
==================
Stoica Armina Georgiana Gabriela
armina.stoica@tantastic.ro
Expansion3-Wages1

Raluca Banita
raluca.banita@tantastic.ro
Trench3-Ravioli3

militari.residence+guest@tantastic.ro
Stifling-Herself6

Roxana Stelian
roxana.stelian@tantastic.ro
Dean8-Ultimate5


Lujerului
=========
Trasnea Georgiana Ionela
georgiana.trasnea@tantastic.ro
Plural9-Prewar4

Zoia Teodorescu
zoia.teodorescu@tantastic.ro
Cosmos5-Critter1


Titan
=====
Mihaela Dumitrascu
mihaela.dumitrascu@tantastic.ro
Disorder5-Face66

Andra Tiurean
andra.tiurean@tantastic.ro
Granola1-Clicker9

Ana Voica
ana.voica@tantastic.ro
Bats4-Mural0

13 Sept
=======
Anfreea Leca
anfreea.leca@tantastic.ro
Mobilize6-Driveway1

Alice Stanciu
alice.stanciu@tantastic.ro
Oxid100-Unzip3


Rahova
======
Iasmina Garoiu
iasmina.garoiu@tantastic.ro
Nearby8-Folic2

Ionela Marin
ionela.marin@tantastic.ro
Dispense7-Gave5


Tineretului
===========
Cristiana Dorneanu
cristiana.dorneanu@tantastic.ro
Replay8-Plural3

Emanuela Brailoiu
emanuela.brailoiu@tantastic.ro
Clarity9-Writing0

Gabriela Balasa
gabriela.balasa@tantastic.ro
Folic2-Dipped7

Anfreea Trandafir
anfreea.trandafir@tantastic.ro
Regain6-Dispense3

Băneasa
=======
Vanessa Stoica
vanessa.stoica@tantastic.ro
Jump2-Replay8

Diana Corduneanu
diana.corduneanu@tantastic.ro
Quote6-Regain2


Crângași
========
Anfreea Negru
anfreea.negru@tantastic.ro
Folic2-Quote6

Nursen Sahin
nursen.sahin@tantastic.ro
Mural0-Delete9

Dacia
=====
Maria Iorgulet
maria.iorgulet@tantastic.ro
Nearby8-Breach9


Tei
===
Anfreea Ciucă
anfreea.ciuca@tantastic.ro
Replay8-Outdated1

Alexandra Anton
alexandra.anton@tantastic.ro
Truce4-Quote6

Iancului
========

Georgiana Constantin
georgiana.constantin@tantastic.ro
Paper5-Evaluate0

Daniela Pavel
daniela.pavel@tantastic.ro
Suitor1-Poem6

Maria Capraroiu
maria.capraroiu@tantastic.ro
Runway6-Harbor3

Anfreea Ciucan
anfreea.ciucan@tantastic.ro
Sprint7-Quote6

Decebal
=======
Ana Oană
ana.oana@tantastic.ro
Regain2-Replay4


Anfreea Dobre
anfreea.dobre@tantastic.ro
Truce4-Unable5

Lucan Larisa
lucan.larisa@tantastic.ro
Evaluate76-Regain12

Pantelimon
==========
Anfreea Ciucan
anfreea.ciucan@tantastic.ro
Nectar1-Dropbox4

Andra Panaitescu
andra.panaitescu@tantastic.ro
Evaluate9-Sublet8

Alexandra Mihalache
alexandra.mihalache@tantastic.ro
Sublet2-Placard1

Simona Dumitrache
simona.dumitrache@tantastic.ro
Delete9-Expand11

Galati
======
lenuta@tantastic.ro
Trickery6-Pellet4

alina@tantastic.ro
Paper9-Runway6

mara@tantastic.ro
Ky5F5jjI9T4fnzQu


Galati Micro 20
======
Ionela Andrii
ionela.andrii@tantastic.ro
Plural3-Aerospace6

Anfreea Codreanu
anfreea.codreanu@tantastic.ro
Runway6-Bats33


Ploiesti
========
Melisa Pisirici
melisa.pisirici@tantastic.ro
Favoring9-Bats1

Alina Popescu
alina.popescu@tantastic.ro
Trombone8-Sprint7

Buzău
=====
Alina Pirvu
alina.pirvu@tantastic.ro
Deviator5-Shorten9

Diana Crunteanu
diana.crunteanu@tantastic.ro
Register9-Jump2

Bacău
=====

Giorgiana Baciu
giorgiana.baciu@tantastic.ro
Nectar4-Clarity8

Anfreea Popa
anfreea.popa@tantastic.ro
Wise12-Skier9

bogdan.ploiesti@tantastic.ro
Plural12-Writing33


marian@tantastic.ro
Skier16-Nectar42



andra+domnesti@tantastic.ro
Posting1-Register7

miruna+domnesti@tantastic.ro
Fling3-Finisher9

alexandra+domnesti@tantastic.ro
Patchy6-Folic44

https://tantastic.cbid.ro/

dana@tantastic.ro
Overuse8-Uneasy1

teo@tantastic.ro
Widely0-Posting22

daria@cj.tantastic.ro
Suitor8-Mural12

madalina@cj.tantastic.ro
Dropbox14-Maximum61


nicoleta.res@tantastic.ro
Deviator11-Sublet68

mihaela.res@tantastic.ro
Trickery49-Daylong3

marian@tantastic.ro
Posting1Expand9


maria.mihalache@tantastic.ro
Sprint7-Wise3

Pascale Andreea
pascale.andreea@tantastic.ro
Decode21-Composite7



Deluge5    Truce4    Ricotta3
Expand9    Granola1  Dispense7
Prewar2    Delete9   Nearby8
Jump2      Gave5     Plural3
Mobilize4  Angled2   Driveway5
Quote6     Cause7    Replay8
Clarity9   Writing0  Acronym8
Ranging1   Folic2    Dipped7
Province7  Regain2  Favoring9
Outback3   Portal4  Outdated1
Senator6   Antiques  Shorten9
Thermal-Mulberry-Uncorrupt7 Eloquence0-Fling-Prissy Cyclic-Trickery6-Replay Swimmer-Perceive-Wolverine8 Seltzer-Anywhere-Pellet4 Sulfide-Quarry-Gurgle7
Dean-Ultimate5-Override Deacon-Smolder1-Snide Passerby-Catlike-Precise
Patchy6-Mortify-Bats Mural0-Muzzle-Chewer Glimpse-Composite2-Decode
Entering-Decrease1-Thyself Phoenix0-Overture-Sulphuric Avid-Breach9-Boaster Deity6-Rope-Lavender Phobia8-Dejected-Placard
Emu-Graveness-Sprint7 Valuables-Trickle0-Slept Paper-Pessimist-Relapsing4 Overuse-Uneasy-Agreement9 Neuter-Drainpipe4-Daylong Unable-Satiable9-Ion
Unvarying-Snuggle2-Yin Bootie-Peculiar2-Powdery Handgun-Nectar-Proclaim2 Harbor-Trombone8-Squash Aerospace6-Skier-Whoever Payphone0-Reclusive-Appease Flyover9-Habitual-Delegator
Evaluate0-Starch-Sincerity Unfitting4-Deviator-Reviver Steering-Finisher9-Suitor Poem6-Goldfish-Flier Dropbox4-Reach-Bubbling Register-Squeezing-Maximum6
Taekwondo-Abridge-Jab0 Unexposed-Elated-Runway6 Sublet8-Wise-Comfy Untying-Widely0-Crate Bacterium-Posting-Geriatric1 Appendix-Scavenger9-Mystified



8268278605637
8268278526802
8268278517657
8268278486793
8268278525850
8268278516254
8268278504428
8268278507474
8268278526703
8268278504978
8268278492480


  def x(twelve)
    twelve = twelve.to_s

    arr = (0..11).to_a.collect do |i|
      if (i+1).even?
        twelve[i,1].to_i * 3
      else
        twelve[i,1].to_i
      end
    end
    sum = arr.inject { |sum, n| sum + n }
    remainder = sum % 10
    if remainder == 0
      check = 0
    else
      check = 10 - remainder
    end

    twelve + check.to_s
  end


[1260, 1261, 1266, 1250, 1256, 1263, 1262, 1264, 1259, 1258, 1254, 1252, 1255, 1257, 1253, 1251, 1265, 1249, 1248, 1247, 1246, 1227, 1241, 1240, 1243, 1236, 1245, 1242, 1239, 1228, 1162, 1165, 1161, 1159, 1156, 1147, 1155, 1150, 1152, 1153, 1163, 1164, 1148, 1149, 1157, 1154, 1160, 1151, 1158, 1166, 1128, 1134, 1130, 1127, 1146, 1140, 1145, 1144, 1129, 1131, 1139, 1138, 1133, 1142, 1143, 1132, 1141, 1135, 1137, 1136, 1116, 1120, 1123, 1126, 1118, 1125, 1121, 1124, 1122, 1114, 1119, 1115, 1117, 1113, 1112, 1111, 1110, 1109, 1108, 1107, 1104, 1090, 1101, 1103, 1100, 1094, 1102, 1093, 1105, 1097, 1106, 1096, 1095, 1098, 1092, 1091, 1099, 1089, 1088, 1087, 1084, 1079, 1083, 1075, 1080, 1077, 1071, 1081, 1076, 1068, 1073, 1082, 1067, 1086, 1078, 1053, 1064, 1054, 1056, 1049, 1055, 1063, 1059, 1060, 1065, 1058, 1052, 1051, 1061, 1050, 1234, 1235, 1233, 1237, 1238, 1231, 1232, 1230, 1244, 1229, 1218, 1226, 1215, 1223, 1224, 1214, 1220, 1216, 1209, 1225, 1212, 1210, 1219, 1213, 1217, 1207, 1221, 1208, 1211, 1222, 1205, 1204, 1206, 1199, 1194, 1187, 1201, 1190, 1192, 1202, 1189, 1188, 1196, 1203, 1198, 1197, 1200, 1193, 1195, 1191, 1182, 1186, 1178, 1170, 1174, 1180, 1179, 1177, 1184, 1181, 1173, 1168, 1175, 1171, 1185, 1169, 1183, 1172, 1167, 1176, 1057, 1066, 1062, 1048, 1047, 1031, 1038, 1045, 1042, 1037, 1043, 1034, 1027, 1028, 1040, 1039, 1046, 1044, 1036, 1035, 1030, 1041, 1033, 1032, 1029, 1019, 1026, 1020, 1022, 1024, 1017, 1021, 1009, 1018, 1014, 1025, 1015, 1011, 1007, 1012, 1013, 1023, 1010, 1016, 1008, 1003, 1006, 1005, 991, 999, 1004, 994, 993, 1002, 975, 972, 980, 970, 969, 968, 967, 951, 962, 957, 960, 961, 964, 956, 950, 958, 955, 963, 953, 954, 948, 1085, 1069, 1072, 1070, 1074, 949, 959, 946, 952, 947, 966, 965, 941, 931, 943, 933, 942, 932, 930, 938, 935, 945, 940, 937, 936, 939, 928, 929, 934, 927, 926, 944, 922, 923, 925, 910, 913, 918, 920, 917, 921, 912, 919, 915, 924, 914, 909, 911, 916, 908, 998, 988, 1001, 997, 1000, 992, 996, 989, 995, 987, 990, 983, 982, 984, 985, 976, 971, 977, 981, 973, 974, 979, 978, 986]

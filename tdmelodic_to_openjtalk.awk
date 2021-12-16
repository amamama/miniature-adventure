BEGIN {
	FS=","
}

function conv_contextID(id) {
	#この変換はunidic 2.1.2の文脈IDが使われると仮定している
	#返すIDはopenjtalkのデフォルトの辞書で用いられる文脈ID
	#unidic-2.2.0を使ってるんだから最新の(現在は3.1.0がある)にしたいが
	#naist-jdicとunidicを全部convertするのはめっちゃめんどい（多分）
	
	if(id == 4786) return 1348;
	else if(id == 5139) return 1345;
	else if(id == 5129) return 1343;
	return id
}

{
	printf("%s", $1); # shokikei
	printf(",%s,%s", conv_contextID($2), conv_contextID($3));
	for(i = 4; i < 11; i++) {
		printf(",%s", $i);
	}
	printf(",%s", $15); # orthBase
	printf(",%s", $16); # 多分本当はkana($25)だが，存在しないのでpronBaseで代用．kanaだと思った理由はopenjtalkのunidicが2.2.0準拠っぽい（https://sourceforge.net/p/open-jtalk/mailman/message/36501953/）ので公式のunidic-csjとにらめっこした．
	gsub("\\[", "", $14);
	gsub("\\]", "", $14);
	printf(",%s", $14); # pron
	printf(",%s", $28); # aType/全体モーラ数
	if($29 == "") $29 = "*";
	printf(",%s", $29); # aConType
	print("");
}

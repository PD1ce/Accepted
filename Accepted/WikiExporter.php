<?php
    
    
    
    
    
    
    
    
    

/*
$file = fopen('/Users/Phil/Desktop/Swift/Accepted/Curls/SchoolURLs.txt','r');
 
while ($line = fgets($file)) {
	$curl = curl_init($line);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
	$page = curl_exec($curl);
	curl_close($curl);

	$regex = '/infobox vcard(.*?)<\/table>/s';
	preg_match($regex, $page, $matches);
	//var_dump($matches[0]);

	//Find School Name
	$nameRegex = '/(?<=bold\">)(.*?)(?=<)/s';
	preg_match($nameRegex, $matches[0], $nameMatches);
	echo("Name : $nameMatches[0]\n");
	//Established Date
	$establishedRegex = '/(?<=(Established<\/th><td>))(.*?)(?=<)/s';
	$establishedRegex = '/(?<=Established<\/th>.<td>)(.*?)(?=(<\/td>)|,)/s';
	preg_match($establishedRegex, $matches[0], $establishedMatches);
	echo("Established : $establishedMatches[0]\n");


}
*/
?>
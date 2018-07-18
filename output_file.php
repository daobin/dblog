<?php
$root_dir = realpath(__DIR__).'/';

$err = '';

$file_type = trim($_GET['file_type']);
switch($file_type){
    case 'pdf':
        $filename = $root_dir.'upload/'.$_GET['file'].'.pdf';
        if(!file_exists($filename)){
            $err = 'notfound';
            break;
        }
        
        $fp = fopen($filename, 'rb');
        if(!$fp){
            $err = 'notopen';
            break;
        }
        
        header('Content-Type: application/pdf');
        header('Content-Length: '.filesize($filename));
        
        while(!feof($fp)){
            echo fread($fp, 500);
        }
        
        fclose($fp);
        break;
    default:
        $err = 'filetype';
        break;
}

if($err != ''){
    header('Location: /?err='.$err);
}

# original setting
#@checkarr = ("FGM","FGA","FTM","FTA","TR","AS","ST","TO","BK","PTS");
#@chkarrnum = (5, 6, 9, 10, 12, 13, 14, 15, 16, 19);
#@namesarr = ("","FG","","FT","TR","AS","ST","TO","BK","PTS");
#
#
# semi-new setting
##PG LAC must add 2
#
#@checkarr  = ("FG","FT","DRB","ORB","AS","ST","BK","PTS","3PT");
#@chkarrnum = (8   , 10 , 6   , 13  , 4  , 15 ,  5 , 14  ,    3);
#@namesarr  = ("FG","FT","DRB","ORB","AS","ST","BK","PTS","3PT");
#yer	3PT	AST	BK	DRB	FG	FGP	FT	FTP	G	Min	ORB	PTS	ST	Rank


#Player           Team PS GP  Min  FGM  FGA  3M  3A FTM  FTA  OR   TR   AS  ST  TO  BK  PF  DQ   PTS  TC  EJ  FF Sta

#PG LAC must add 2
@checkarr  = ("FGM","FGA","FTM","FTA","TR","OR","AS","ST","BK","PTS","3M");
@chkarrnum = (5   ,6 ,9  ,10, 12   , 11  , 13  , 14 ,  16 , 19  ,    7);
@namesarr  = ("FGM","FGA","FTM","FTA","TR","OR","AS","ST","BK","PTS","3M");







for ($idxval = 0; $idxval < @checkarr; $idxval++)
{
   open(INFILE, "seasonstats.txt.2012") or die "seasonstats.txt.2012: $!";

   %players = ();

   while ($line = <INFILE>)
   {
      chop($line);
      @temparr = ();
      @temparr = split(/[ \t]+/, $line);
      $birdie = 0;
      $newbirdie = 0;
      $newbirdie2 = 0;
      $tempstring = "";

      $birdie = $temparr[$chkarrnum[$idxval]];
      $tempstring = $temparr[0]." ".$temparr[3];

	print "$newbirdie";
	print "\n";
		print $tempstring;
		print "\n";


      push(@{$players{$birdie}}, $tempstring);
      sort @{$players{$birdie}};
   }

   $tempstring = ">out.".$namesarr[$idxval];
   open(OUTFILE, $tempstring) or die "$tempstring: $!"; 


	print "DEBUG2:  opened $tempstring";
	print "\n";

	print "DEBUG2:  looping throug players loop on  $namesarr[$idxval]";
	print "\n";

	$key = "";

   foreach $key (reverse (sort { $a <=> $b} (keys %players)))
   {
		print "DEBUG3:  key = $key";
		print "\n";

      @temp = ();
      push(@temp, @{$players{$key}});
      for ($i = 0; $i < @temp; $i++)
      {
            printf OUTFILE "%d\t%-20s\n", $key, $temp[$i];
            printf "DEBUG3:  %d\t%-20s\n", $key, $temp[$i];
      }
   }

   close(INFILE);
   close(OUTFILE);
}

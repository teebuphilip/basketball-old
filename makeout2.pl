#Player  3PT     AST     BK      DRB     FG      FGP     FT      FTP     G       Min     ORB     PTS     ST      Rank

#Player  3PT     AST     BK      DRB     FG      FGP     FT      FTP     G       Min     ORB     PTS     ST      Rank
#Paul,Chris PG LAC       71      782     5       289     430     46.3    337     87.8    80      2880    38      1268
#        188     1


#PG LAC must add 2

@checkarr  = ("FG","FT","DRB","ORB","AS","ST","BK","PTS","3PT");
@chkarrnum = (8   , 10 , 6   , 13  , 4  , 15 ,  5 , 14  ,    3);
@namesarr  = ("FG","FT","DRB","ORB","AS","ST","BK","PTS","3PT");


for ($idxval = 0; $idxval < @checkarr; $idxval++)
{
   open(INFILE, "seasonstats.txt.2010.2") or die "seasonstats.txt.2010.2: $!";

   %players = ();

   while ($line = <INFILE>)
   {
      chop($line);
      @temparr = ();
      @temparr = split(/[ \t]+/, $line);
      $birdie = 0;
      $tempstring = "";

         $birdie = $temparr[$chkarrnum[$idxval]];
         $tempstring = $temparr[0]." ".$temparr[11];

      push(@{$players{$birdie}}, $tempstring);
      sort @{$players{$birdie}};
   }

   $tempstring = ">out.".$namesarr[$idxval];
   open(OUTFILE, $tempstring) or die "$tempstring: $!"; 

   foreach $key (reverse (sort { $a <=> $b} (keys %players)))
   {
      @temp = ();
      push(@temp, @{$players{$key}});
      for ($i = 0; $i < @temp; $i++)
      {
            printf OUTFILE "%d\t%-20s\n", $key, $temp[$i];
      }
   }

   close(INFILE);
   close(OUTFILE);
}

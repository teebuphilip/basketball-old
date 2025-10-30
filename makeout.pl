@checkarr = ("FGM","FGA","FTM","FTA","TR","AS","ST","TO","BK","PTS");
@chkarrnum = (5, 6, 9, 10, 12, 13, 14, 15, 16, 19);
@namesarr = ("","FG","","FT","TR","AS","ST","TO","BK","PTS");


for ($idxval = 0; $idxval < @checkarr; $idxval++)
{
   open(INFILE, "seasonstats.txt") or die "seasonstats.txt: $!";

   %players = ();

   while ($line = <INFILE>)
   {
      chop($line);
      @temparr = ();
      @temparr = split(/[ \t]+/, $line);
      $birdie = 0;
      $tempstring = "";

      if (($idxval != 0) && ($idxval != 2))
      {
         $birdie = $temparr[$chkarrnum[$idxval]];
         $tempstring = $temparr[0]." ".$temparr[3];
      }

      else
      {
         if ($temparr[$chkarrnum[$idxval + 1]] != 0)
         {
            $birdie = $temparr[$chkarrnum[$idxval]] / $temparr[$chkarrnum[$idxval + 1]];
         }

         $tempstring = $temparr[0]." ".$temparr[3]." -- ".$temparr[$chkarrnum[$idxval]]." of ".$temparr[$chkarrnum[$idxval+ 1]];
      }

      push(@{$players{$birdie}}, $tempstring);
      sort @{$players{$birdie}};
   }

   if (($idxval == 0) || ($idxval == 2))
   {
      $idxval++;
   }
   $tempstring = ">out.".$namesarr[$idxval];
   open(OUTFILE, $tempstring) or die "$tempstring: $!"; 

   foreach $key (reverse (sort { $a <=> $b} (keys %players)))
   {
      @temp = ();
      push(@temp, @{$players{$key}});
      for ($i = 0; $i < @temp; $i++)
      {
	 if ($idxval <= 3)
         {
            printf OUTFILE "%.3f\t%-20s\n", $key, $temp[$i];
         }
         else
         {
            printf OUTFILE "%d\t%-20s\n", $key, $temp[$i];
         }
      }
   }

   close(INFILE);
   close(OUTFILE);
}

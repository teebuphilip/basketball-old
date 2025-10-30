# $line[1] = `cat out.* | grep "duncan,t"`;
# $line[1] = `cat out.* | grep "ratliff,t"`;
# $line[1] = `cat out.* | grep "rahim,s"`;

#bash-3.2$ cat out.* | grep duncan,tim
#2       duncan,tim 69
#184     duncan,tim 69
#182     duncan,tim 69
#976     duncan,tim 69
#490     duncan,tim 69
#300     duncan,tim 69
#245     duncan,tim 69
#125     duncan,tim 69
#1227    duncan,tim 69
#50      duncan,tim 69
#686     duncan,tim 69
#bash-3.2$ ls out*
#out.3M   out.BK   out.FGM  out.FTM  out.PTS  out.TR
#out.AS   out.FGA  out.FTA  out.OR   out.ST

@totalplayers = ();
# @players = ("duncan", "rahim", "ratliff", "williamson", "christie", "starks");
@categories = ("3 Made", "Assists", "Blocks", "FG Per", "FG Made", "FT Per", "FT Made", "ORebounds", "Points", "Steals", "DRebounds");
@totals = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
#12 players
#@weekly = (43, 130, 35, 47, 231, 75, 115, 64, 610, 46, 196);
@singleton = (43/14, 142/14, 41/14, 47, 231/14, 75, 115/14, 64, 712, 54, 196);
@weekly = (43, 142, 41, 47, 231, 75, 115, 64, 712, 54, 196);





if ($ARGV[0] ne "")
{
   @newplayers = split(/:/, $ARGV[0]);
}

else
{
   @newplayers = ();
}

push(@players, @newplayers);

if (@players > 14)
{
   print "Too many players\n";
   exit(1);
}

for ($i = 0; $i < @players; $i++)
{
   push(@totalplayers,$players[$i]);
   $line = `cat out.* | grep "$players[$i]"`; 

   @newlines = split(/\n/, $line);

   if (@newlines != 11)
   {
      print "Check out $players[$i]\n";
      exit(1);
   }

   for ($k = $j = 0; $j < @newlines; $j++)
   {
         @string = split(/[ \t]+/, $newlines[$j]);
         $lastentr = @string - 1;
         $avg = $string[$lastentr - 2] / $string[$lastentr];
         $totals[$k++] += ($avg * 3.33);
   }
}


print "Here are the cum weekly numbs with the following players\n";
for ($i = 0; $i < @totalplayers; $i++)
{
   print "$totalplayers[$i]\n";
}

print "\n\n";

for ($i = 0; $i < @weekly; $i++)
{
   if (($i == 3) || ($i == 5))
   {
      @newarr = ($totals[$i + 1], $totals[$i]);
      @temparr = ($weekly[$i], 100);
      printf "%s Total So Far: %.4f,%d for %d\tNeed to hit %.4f\n",
             $categories[$i], ($newarr[0] / $newarr[1]), $newarr[0],
             $newarr[1], ($temparr[0] / $temparr[1]);
   }

   else
   {
      if ((14 - @totalplayers) != 0)
      { 
         printf "%s Total So Far: %.1f\t\tNeed to get: %.1f\tPer guy per game: %.1f\n",
          $categories[$i], $totals[$i], $weekly[$i] - $totals[$i],
          (($weekly[$i] - $totals[$i]) / ((14 - @totalplayers) * 3.33));
      }

      else
      {
         printf "%s Total So Far: %.1f\tNeed to get: %.1f\n",
           $categories[$i], $totals[$i], $weekly[$i] - $totals[$i];
      }
   }
}


if (@totalplayers < 14)
{
   printf "\n\nGet %d more players.\n", 14 - @totalplayers;
}

exit(0);

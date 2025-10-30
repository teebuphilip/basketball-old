@totalplayers = ();
@categories = ("Assists", "Blocks", "FGM", "FGA", "FTM", "FTA", "Points", "Steals", "Rebounds");
@totals = (0, 0, 0, 0, 0, 0, 0, 0, 0);



if ($ARGV[0] ne "")
{
   $searchforplayer = $player = $ARGV[0];
   $line = `cat out.* | grep "$player"`; 

   @newlines = split(/\n/, $line);
   for ($k = $j = 0; $j < @newlines; $j++)
   {
#      print "j = $j\n";
      if (($j == 2) || ($j == 3))
      {
        @string1 = split(/\-\-/, $newlines[$j]);
        @string = split(/of/, $string1[1]);
        $totals[$k++] += $string[0];
        $totals[$k++] += $string[1];
      }

      elsif ($j == 6)
      {
      }

      else
      {
         @string = split(/[ \t]+/, $newlines[$j]);
         $lastentr = @string - 1;
#         print "lastentr = $lastentr, $string[$lastentr]\n";
#         print "@string\n";
         $avg = $string[$lastentr - 2] / $string[$lastentr];
         $gamesplayed = $string[$lastentr];
         $totals[$k++] += ($avg * 4);
      }
   }

   print "Stats for $player are:\n"; 
   print "Games Played is $gamesplayed.\n";


   for ($i = 0; $i < @totals; $i++)
   {
      if (($i == 2) || ($i == 4))
      {
         printf "%s percentage is %.3f.\n", $categories[$i], ($totals[$i] / $totals[$i + 1]);
         $i++;
      }

      else
      {
         printf "%s is %.3f.\n", $categories[$i], ($totals[$i] / 4);
      }
   }
}


else
{
   die("PGM ends with no input.\n");
}


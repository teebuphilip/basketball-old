$pointsavg = $ARGV[0];
@totals = ($ARGV[1], $ARGV[2]);

if (open(INFILE, "out.PTS") == 0)
{
   die("unable to open out.PTS");
}

@likeplayers = ();

while ($line = <INFILE>)
{
   chop($line);
   @arr = split(/[ \t]+/, $line);
   $lastentr = @arr - 1;
   $avg = $arr[$lastentr - 2] / $arr[$lastentr];

#   $avg = ($arr[0] / $arr[2]);
   if ($avg >= $pointsavg)
   {
      push(@likeplayers, $arr[1]);
   }
}

# print "Here are the list of players like $searchforplayer in scoring:\n";
# print "@likeplayers\n";

close(INFILE);

for ($i = 0; $i < @likeplayers; $i++)
{
   $line = `cat out.AS out.TR | grep "$likeplayers[$i]"`;

   @newlines = split(/\n/, $line);

   $badplayer = 0;

   for ($k = $j = 0; $j < @newlines; $j++)
   {
      @string = split(/[ \t]+/, $newlines[$j]);
      $lastentr = @string - 1;
      $avg = $string[$lastentr - 2] / $string[$lastentr];

#      $avg = $string[0] / $string[2];
      if ($avg < $totals[$k++])
      {
         $badplayer = 1;
         next;
      }
   }

   if ($badplayer == 0)
   {
      push(@verylikeplayer, $likeplayers[$i]);
   }
}

@newtots = ($pointsavg);
push(@newtots, @totals);

print "Here is the list of players with stats equal to or better than @newtots\n";
for ($i = 0; $i < @verylikeplayer; $i++)
{
   print "$verylikeplayer[$i]\n";
}

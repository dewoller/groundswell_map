#!/usr/bin/perl -w

use strict;
my $intro = q| 
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>lines</name>
    <Style id="line-000000-1200-nodesc-normal">
      <LineStyle>
        <color>ff000000</color>
        <width>1</width>
      </LineStyle>
      <BalloonStyle>
        <text><![CDATA[<h3>$[name]</h3>]]></text>
      </BalloonStyle>
    </Style>
    <StyleMap id="line-000000-1200-nodesc">
      <Pair>
        <key>normal</key>
        <styleUrl>#line-000000-1200-nodesc-normal</styleUrl>
      </Pair>
      <Pair>
        <key>highlight</key>
        <styleUrl>#line-000000-1200-nodesc-highlight</styleUrl>
      </Pair>
    </StyleMap>
|;
my $ed=q|
  </Document>
</kml>
|;

print($intro);
while (<>) {
	next if m/Label/;
	chomp; 
	my @e = split(/,/);
	print( qq|
    <Placemark>
      <name>$e[0]</name>
      <styleUrl>#line-000000-1200-nodesc</styleUrl>
      <LineString>
        <tessellate>1</tessellate>
        <coordinates>
          $e[1], $e[2], 0
          $e[3], $e[4], 0
        </coordinates>
      </LineString>
    </Placemark>
|);
}
print($ed);

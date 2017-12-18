#!/usr/bin/perl -w

use strict;
use Text::Template;

my @categories=qw(
Banyule_Council
Business
Social_Enterprise
Neighbourhood_House
Community_Garden
Project
Conservation_Group
Community_Group
Intentional_Community
Network
School
Transition_Group
Food_Swap
);



my $iconStyleTemplate = Text::Template->new(
    type => "STRING",
    source =>q|
    <Style id="icon-1899-{$iconName}-nodesc-normal">
      <IconStyle>
        <color>{$iconColor}</color>
        <scale>1</scale>
        <Icon>
          <href>images/{$iconName}.png</href>
        </Icon>
        <hotSpot x="16" xunits="pixels" y="32" yunits="insetPixels"/>
      </IconStyle>
      <LabelStyle>
        <scale>0</scale>
      </LabelStyle>
      <BalloonStyle>
        <text><![CDATA[<h3>$[name]</h3>]]></text>
      </BalloonStyle>
    </Style>
    <Style id="icon-1899-{$iconName}-nodesc-highlight">
      <IconStyle>
        <color>{$iconColor}</color>
        <scale>1</scale>
        <Icon>
          <href>images/{$iconName}.png</href>
        </Icon>
        <hotSpot x="16" xunits="pixels" y="32" yunits="insetPixels"/>
      </IconStyle>
      <LabelStyle>
        <scale>1</scale>
      </LabelStyle>
      <BalloonStyle>
        <text><![CDATA[<h3>$[name]</h3>]]></text>
      </BalloonStyle>
    </Style>
    <StyleMap id="icon-1899-{$iconName}-nodesc">
      <Pair>
        <key>normal</key>
        <styleUrl>#icon-1899-{$iconName}-nodesc-normal</styleUrl>
      </Pair>
      <Pair>
        <key>highlight</key>
        <styleUrl>#icon-1899-{$iconName}-nodesc-highlight</styleUrl>
      </Pair>
    </StyleMap>
|);

my $pointTemplate=Text::Template->new(
    type => "STRING",
    source =>q|
	<Placemark>
      <name>{$pointName}</name>
      <description>{$pointDesc}</description>
      <styleUrl>#icon-1899-{$iconName}-nodesc</styleUrl>
      <Point>
        <coordinates>
		{$pointLon},{$pointLat},0
        </coordinates>
      </Point>
    </Placemark>
|);


my $iconColor = "ffd18802";

my $intro = q|<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>Untitled layer</name>
|;
my $ed=q|
  </Document>
</kml>
|;

print($intro);

foreach my $category (@categories) {
	print $iconStyleTemplate ->fill_in(
    hash => {
        iconColor => $iconColor,
        iconName => $category,
		},
	);
}

while (<>) {
	next if m/Map Category/;
	chomp; 
	my @e = split(/,/);
	my $category = $e[0];
	$category =~ s/ /_/g;

	print $pointTemplate ->fill_in(
		hash => {
			pointName => $e[1],
			pointDesc => $e[0],
			pointLon => $e[3],
			pointLat => $e[2],
			iconName => $category,
			},
	);
	
}
print($ed);

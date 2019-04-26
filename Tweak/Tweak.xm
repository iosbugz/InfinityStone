#import <Cephei/HBPreferences.h>

static NSDictionary *prefixes = @{
    @"InfinityStone": @[@"", @"", @"", @"", @"", @"", @"", @""]
};

static NSDictionary *suffixes = @{
    @"InfinityStone": @[@" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @", ", @" ", @" ", @" ", @" ", @" "]
};

static NSDictionary *replacement = @{
    @"InfinityStone": @{
        @"avenger": @"SPOILER!",
		@"captain america": @"SPOILER!",
        @"thanos": @"SPOILER!",
        @"iron man": @"SPOILER!",
        @"spiderman": @"SPOILER!",
        @"spider man": @"SPOILER!",
        @"ironman": @"SPOILER!",
        @"hulk": @"SPOILER!",
        @"blackpanther": @"SPOILER!",
        @"tony": @"SPOILER!",
		@"stark": @"SPOILER!",
		@"antman": @"SPOILER!",
		@"ant man": @"SPOILER!",
		@"marvel": @"SPOILER!",
		@"captainmarvel": @"SPOILER!",
		@"thor": @"SPOILER!",
		@"loki": @"SPOILER!",
		@"russo": @"SPOILER!",
		@"endgame": @"SPOILER!",
		@"peter parker": @"SPOILER!",
		@"ant-man": @"SPOILER!",
		@"star lord": @"SPOILER!",
		@"star-lord": @"SPOILER!",
		@"gamora": @"SPOILER!",
		@"groot": @"SPOILER!",
		@"drax": @"SPOILER!",
		@"rocket": @"SPOILER!",
		@"rocket raccoon": @"SPOILER!",
		@"Avenger": @"SPOILER!",
		@"Captain America": @"SPOILER!",
        @"Thanos": @"SPOILER!",
        @"Iron Man": @"SPOILER!",
        @"Spiderman": @"SPOILER!",
        @"Spider Man": @"SPOILER!",
        @"Ironman": @"SPOILER!",
        @"Hulk": @"SPOILER!",
        @"Blackpanther": @"SPOILER!",
        @"Tony": @"SPOILER!",
		@"Stark": @"SPOILER!",
		@"Antman": @"SPOILER!",
		@"Ant Man": @"SPOILER!",
		@"Marvel": @"SPOILER!",
		@"Captainmarvel": @"SPOILER!",
		@"Thor": @"SPOILER!",
		@"Loki": @"SPOILER!",
		@"Russo": @"SPOILER!",
		@"Endgame": @"SPOILER!",
		@"Peter Parker": @"SPOILER!",
		@"Ant-Man": @"SPOILER!",
		@"Star Lord": @"SPOILER!",
		@"Star-Lord": @"SPOILER!",
		@"Gamora": @"SPOILER!",
		@"Groot": @"SPOILER!",
		@"Drax": @"SPOILER!",
		@"Rocket": @"SPOILER!",
		@"Rocket Raccoon": @"SPOILER!",
		@"AVENGER": @"SPOILER!",
		@"CAPTAIN AMERICA": @"SPOILER!",
        @"THANOS": @"SPOILER!",
        @"IRON MAN": @"SPOILER!",
        @"SPIDERMAN": @"SPOILER!",
        @"SPIDER MAN": @"SPOILER!",
        @"IRONMAN": @"SPOILER!",
        @"HULK": @"SPOILER!",
        @"BLACKPANTHER": @"SPOILER!",
        @"TONY": @"SPOILER!",
		@"STARK": @"SPOILER!",
		@"ANTMAN": @"SPOILER!",
		@"ANT MAN": @"SPOILER!",
		@"MARVEL": @"SPOILER!",
		@"CAPTAIN MARVEL": @"SPOILER!",
		@"THOR": @"SPOILER!",
		@"LOKI": @"SPOILER!",
		@"RUSSO": @"SPOILER!",
		@"ENDGAME": @"SPOILER!",
		@"PETER PARKER": @"SPOILER!",
		@"ANT-MAN": @"SPOILER!",
		@"STAR LORD": @"SPOILER!",
		@"STAR-LORD": @"SPOILER!",
		@"GAMORA": @"SPOILER!",
		@"GROOT": @"SPOILER!",
		@"DRAX": @"SPOILER!",
		@"ROCKET": @"SPOILER!",
		@"ROCKET RACCOON": @"SPOILER!",
    }
};

static NSString *mode = nil;

NSString *owoify (NSString *text, bool replacementOnly) {
    NSString *temp = [text copy];
    
    if (replacement[mode]) {
        for (NSString *key in replacement[mode]) {
            temp = [temp stringByReplacingOccurrencesOfString:key withString:replacement[mode][key]];
        }
    }

    if (replacementOnly) return temp;

    if (prefixes[mode]) {
        temp = [prefixes[mode][arc4random() % [prefixes[mode] count]] stringByAppendingString:temp];
    }

    if (suffixes[mode]) {
        temp = [temp stringByAppendingString:suffixes[mode][arc4random() % [suffixes[mode] count]]];
    }

    return temp;
}

%group OwONotifications

%hook NCNotificationContentView

-(void)setPrimaryText:(NSString *)orig {
    if (!orig) {
        %orig(orig);
        return;
    }
    
    %orig(owoify(orig, true));
}

-(void)setSecondaryText:(NSString *)orig {
    if (!orig) {
        %orig(orig);
        return;
    }
    
    %orig(owoify(orig, false));
}

%end

%end

%group OwOEverywhere

%hook UILabel

-(void)setText:(NSString *)orig {
    if (!orig) {
        %orig(orig);
        return;
    }
    
    %orig(owoify(orig, true));
}

%end

%end

%group OwOIconLabels

%hook SBIconLabelImageParameters

-(NSString *)text {
    return owoify(%orig, true);
}

%end

%end

%group OwOSettings

%hook PSSpecifier

-(NSString *)name {
    return owoify(%orig, true);
}

%end

%end

%ctor {
    if (![NSProcessInfo processInfo]) return;
    NSString *processName = [NSProcessInfo processInfo].processName;
    bool isSpringboard = [@"SpringBoard" isEqualToString:processName];

    // Someone smarter than me invented this.
    // https://www.reddit.com/r/jailbreak/comments/4yz5v5/questionremote_messages_not_enabling/d6rlh88/
    bool shouldLoad = NO;
    NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
    NSUInteger count = args.count;
    if (count != 0) {
        NSString *executablePath = args[0];
        if (executablePath) {
            NSString *processName = [executablePath lastPathComponent];
            BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
            BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
            BOOL skip = [processName isEqualToString:@"AdSheet"]
                        || [processName isEqualToString:@"CoreAuthUI"]
                        || [processName isEqualToString:@"InCallService"]
                        || [processName isEqualToString:@"MessagesNotificationViewService"]
                        || [executablePath rangeOfString:@".appex/"].location != NSNotFound;
            if ((!isFileProvider && isApplication && !skip) || isSpringboard) {
                shouldLoad = YES;
            }
        }
    }

    if (!shouldLoad) return;

    HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"me.thanos.infinitystone"];

    if ([([file objectForKey:@"Enabled"] ?: @(YES)) boolValue]) {
        mode = [file objectForKey:@"Style"] ?: @"InfinityStone";

        if ([([file objectForKey:@"EnabledEverywhere"] ?: @(NO)) boolValue]) {
            %init(OwOEverywhere);
        }

        if ([([file objectForKey:@"EnabledSettings"] ?: @(NO)) boolValue]) {
            %init(OwOSettings);
        }

        if (isSpringboard) {
            if ([([file objectForKey:@"EnabledNotifications"] ?: @(YES)) boolValue]) {
                %init(OwONotifications);
            }

            if ([([file objectForKey:@"EnabledIconLabels"] ?: @(NO)) boolValue]) {
                %init(OwOIconLabels);
            }
        }
    }
}

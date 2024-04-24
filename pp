// ==UserScript==
// @name         Restocking Profit Highlighter (Plushie Palace)
// @namespace    http://www.jellyneo.com
// @version      1.1
// @description  Automatically highlights profitable items in Neopets stores.
// @author       MediaTriggerWords, ayyylmao, modified by Astralruby on Jellyneo
// @match        https://www.neopets.com/objects.phtml?type=shop&obj_type=98
// @grant        none
// ==/UserScript==

(function() {

    var patterns = [], classes = [];

    /*    The following define the classes of words.  If the first
    character of the specification is "=", the match will be
    case-sensitive, otherwise it will be case-insensitive.
    The specification is a regular expression, and should
    contain metacharacters to handle variant spellings and
    plurals.  Any grouping within these patterns *must* be done
    with a (?: ... ) specification to avoid messing up the
    capture from the text string.

    You may add additional categories as you wish, but be sure to
    declare their rendering in the style definition below.  */

    //    Rendering styles for our various word classes

    addGlobalStyle('span.red { background-color: #000000; color: #ff1a00; } ' +
           'span.yellow { background-color: #000000; color: #fdff00;} ' +
           'span.green { background-color: #000000; color: #23ea11;} ' +
                 'span.blue { background-color: #000000; color: #01fcfc} ' );

    // RED items. Items in this list will appear as red on black

    defwords(["Baby Flotsam Plushie", "Brown Draik Plushie", "Faerie Kyrii Plushie", "Malevolent Fungus Plushie", "Orrin Plushie", "Potato Plushie", "Royal Girl Ixi Plushie", "Valentine Grarrl Plushie", "White Ixi Plushie", "Giant Oversized Symol Plushie", "Pink Slorg Plushie", "Tekkitu Plushie", "Transparent Lupe Plushie", "Collectors Edition Quiguki Girl Plushie", "Thornberry Chia Plushie", "Ramtor the Advisor Plushie", "Valentines Grundo Plushie", "Christmas JubJub Plushie", "Mutant Acara Plushie", "Chocolate Gnorbu Plushie", "Island JubJub Plushie", "Number 1 Plushie", "Spotted Kau Plushie", "Orange Chia Plushie", "Pirate Gnorbu Plushie", "Quiguki Boy Plushie", "Reject Red Acara Plushie", "Snot Quiggle Plushie", "Woodland Uni Plushie", "Wraith Cybunny Plushie", "Maraquan Slorg Plushie", "Pirate Nimmo Plushie", "Baby Chomby Plushie", "Milo Plushie", "Pink Babaa Plushie", "Pink Worm Plushie", "Disco JubJub Plushie", "Evil Eldest Drenched Sister Plushie", "Faerie Ruki Plushie", "Mutant Uni Plushie", "Faerie Kau Plushie", "Rourke Plushie", "Speckled Ixi Plushie", "Un-Valentines Blumaroo Plushie", "Grarrg Action Plushie", "Striped Meerca Plushie", "Chocolate Uni Plushie", "Plumpy Plushie", "Starry Buzz Plushie", "Mutant Bori Plushie", "Valentine Chomby Plushie", "Zombie Ixi Plushie", "Zombie Moehog Plushie", "Dire Lupe Neoquest Plushie", "Jazzmosis Nimmo Plushie", "Pink Scorchio Plushie", "Aubergine Chia Plushie", "Baby Draik Plushie", "Baby Lenny Plushie", "Faerie Koi Plushie", "Judge Hog Plushie", "New Years Moehog Plushie", "Pirate Ruki Plushie", "Darigan Techo Plushie", "Blue Scorchio Plushie", "Halloween Jetsam Plushie", "Mutant Xweetok Plushie", "Xampher Plushie", "Pirate Tuskaninny Plushie", "Electric Korbat Plushie", "Tyrannian JubJub Plushie", "Biscuit Yurble Plushie", "Electric Aisha Plushie", "Grey Acara Plushie", "Rainbow Peophin Plushie", "White Anubis Plushie", "Baby Eyrie Plushie", "Robot Hissi Plushie", "Donny Plushie", "Talek Plushie", "Assassin Plushie", "Ursula Plushie", "Magma Grarrl Plushie", "Maraquan Blumaroo Plushie", "Royalgirl Flotsam Plushie", "Black Evil Fuzzle", "Darigan Yurble Plushie", "Draik Guard Plushie", "Valentines Chia Plushie", "Toy Shop Shopkeeper Plushie", "Fire Lupe Plushie", "Halloween Wocky Plushie", "Maractite Lutari Plushie", "Plushie Korbat Plushie", "Pirate Fuzzle", "Faerie Hissi Plushie", "Baby Ogrin Plushie", "Deadeye Plushie", "Orange Xweetok Plushie", "Rower Plushie", "The Ghost Lupe Plushie", "White Lupe Plushie", "Faerie Lutari Plushie", "Maraquan Kyrii Plushie", "Desert Krawk Plushie", "Magma Lutari Plushie", "Meepit Plushie", "Maraquan Eyrie Plushie", "Ghost Brush Plushie", "Grey Hissi Plushie", "Jazzmosis Blumaroo Plushie", "Plushie Shoyru Plushie", "Stealthy Techo Plushie", "Baby Blumaroo Plushie", "Grey Korbat Plushie", "Acara Acrobat Plushie", "Darigan Usul Plushie", "Royal Boy Bori Plushie", "Candy Aisha Plushie", "Cheeseroller Shopkeeper Plushie", "Cloud Yurble Plushie", "Halloween Bruce Plushie", "Orange Skeith Plushie", "Pink Doglefox Plushie", "Rigger Plushie", "Sir Edmund Ogletree Plushie", "Yellow Ixi Plushie", "Robot Scorchio Plushie", "Snow Beast Plushie", "Faerie Flotsam Plushie", "Purple Buzz Plushie", "Skeith Judge Plushie", "Taco Plushie", "Burlap Kacheek Plushie", "Chocolate Ogrin Plushie", "Extra Soft Auction Genie Plushie", "Halloween Lenny Plushie", "Shoyru with Flatfruit Plushie", "Baby Brush Plushie", "Deluxe Gwyl Plushie", "Purple Korbat Plushie", "Rainbow Tonu Plushie", "Darigan Elemental Plushie", "Gordos Plushie", "Plushie Bori Plushie", "Darigan Mynci Plushie", "Island Zafara Plushie", "Starry Bruce Plushie", "Thyassa Plushie", "Desert Cybunny Plushie", "Desert Draik Plushie", "Royal Girl Bori Plushie", "Senator Barca Plushie", "Shadow Flotsam Plushie", "Gilly Plushie", "Halloween Blumaroo Plushie", "Kavennagh Plushie", "Lupe Birthday Plushie", "Mutant Flotsam Plushie", "Mutant Skeith Plushie", "Tyrannian Peophin Plushie", "Un-Valentines Cybunny Plushie", "Desert Lutari Plushie", "Gardening Centre Shopkeeper Plushie", "Ice Crystal Shopkeeper Plushie", "Un-Valentines Xweetok Plushie", "Yellow Tonu Plushie", "Royalboy Flotsam Plushie", "Cherub Acara Plushie", "Cloud Acara Plushie", "Coconut JubJub Plushie", "Doglefox Plushie", "Electric Bruce Plushie", "Lady Osiri Plushie", "Magma Moehog Plushie", "Maraquan Bruce Plushie", "Royal Girl Bruce Plushie", "Split Tonu Plushie", "Underwater Chef Plushie", "Whinny Plushie", "Woodland Grundo Plushie","Grarrg Battle Plushie", "Darigan Grarrl Plushie", "Darigan Buzz Plushie", "Number 3 Plushie", "Angry Vira Plushie", "Sausage Plushie", "Maraquan Shoyru Plushie", "Zombie Fuzzle", "Number 5 Plushie", "Fire Blumaroo Plushie", "Tyrannian Tuskaninny Plushie", "Darigan Grundo Plushie", "Starry Skeith Plushie", "Bruce Smuggler Plushie", "Pirate Techo Plushie", "Captain Rourke Plushie", "Grey Usul Plushie", "Lenny Smuggler Plushie", "Grey Blumaroo Plushie", "Mauket Plushie", "Starry Scorchio Plushie", "Pant Devil Plushie", "Galgarroth Plushie", "Captain Tuan Plushie", "Cassile Plushie", "Talinia Plushie"], "red");

    //    YELLOW words. These items are black background with yellow text.

    defwords(["Island Peophin Plushie", "Rainbow Negg Plushie", "Alien Aisha Plushie", "Maraquan Techo Plushie", "Handcrafted Tomos Plushie", "Mutant Evil Fuzzle", "Electric Ixi Plushie", "Grizzly Bearog Plushie", "Grey Chomby Plushie", "Starry Evil Fuzzle", "Striped Evil Fuzzle", "Silver Kougra Plushie", "Purple Koi Plushie", "Stone Golem Neoquest Plushie", "Orange Gelert Plushie", "Roburg Plushie", "Darigan Uni Plushie", "Halloween Lupe Plushie", "Iron Golem Neoquest Plushie", "Chokato Plushie", "Mutant Techo Plushie", "Island Ogrin Plushie", "Christmas Chomby Plushie", "Starry Yurble Plushie", "Evil Twin Green Quiggle Plushie", "Speckled Moehog Plushie", "Fire Koi Plushie", "Halloween Peophin Plushie", "Scoach Plushie", "Striped Fuzzle", "Blue Peophin Squishy Plushie", "Magma Tonu Plushie", "Bonju Plushie", "Valentines Kadoatie Plushie", "Green Peophin Squishy Plushie", "Rainbow Anubis Plushie", "Symol Plushie", "Royal Boy Kyrii Plushie", "Palace Guard Plushie", "Darigan Kau Plushie", "Striped Skeith Plushie", "Baelia Plushie", "Halloween Kougra Plushie", "Evil Twin Red Scorchio Plushie", "Brown Uni Plushie", "Baby Chia Plushie", "Ghost Ogrin Plushie", "Red Yurble Plushie", "Rainbow Cybunny Plushie", "White Yurble Plushie", "Kacheek Shepherd Plushie", "Plushie Acara Plushie", "Purple Kougra Plushie", "Royal Boy Usul Plushie", "Red Peophin Squishy Plushie", "Pirate Poogle Plushie", "Ghost Toast Plushie", "Chicken Leg Plushie", "Orange Peophin Squishy Plushie", "Robot Gnorbu Plushie", "Draphly Plushie", "Chocolate Draik Plushie", "Black Doglefox Plushie", "King Kelpbeard Plushie", "Sloth Snowbunny Plushie", "Gold Evil Fuzzle", "Zombie Cybunny Plushie", "Valentines Kacheek Plushie", "Sentient Tombstone Plushie", "Shadow Tonu Plushie", "Rorru Plushie", "Shadow Draik Plushie", "Baby Kacheek Plushie", "Deluxe Baby Quiggle Plushie", "Jazzmosis Chia Plushie", "King Roo Plushie", "Sand Golem Neoquest Plushie", "Velm Plushie", "Pink Cupcake Plushie", "Faerie Grundo Plushie", "Brown Lenny Plushie", "Darigan Ixi Plushie", "Shumi Plushie", "Handcrafted Illusen Plushie", "Pirate Krawk Plushie", "Royal Girl Kougra Plushie", "Dirt Golem Neoquest Plushie", "Mutant Bruce Plushie", "Sponge Cybunny Plushie", "Rainbow Gelert Plushie", "Ugly Bruno Plushie", "Valentines Faellie Plushie", "Swabbie Plushie", "Meowclops Plushie", "Pineapple Chia Plushie", "Disco Nimmo Plushie", "Faerie Brush Plushie", "Magma Lenny Plushie", "Mutant Gelert Plushie", "Shadow Usul Plushie", "Kentari Plushie", "Maraquan Gelert Plushie", "Coffee Shopkeeper Plushie", "Bruce with Twirly Fruit Plushie", "Island Gelert Plushie", "Two Rings Archmagus Plushie", "Cave Lupe Neoquest Plushie", "Frost Lizard Plushie", "Plushie Kougra Plushie", "Starry Shoyru Plushie", "Faerie Peophin Plushie", "Maraquan Skeith Plushie", "Hoban Plushie", "Pink Lenny Plushie", "Zombie Buzz Plushie", "Valentines Quiggle Plushie", "Chocolate Kougra Plushie", "Mutant Hissi Plushie", "Angry Royal Girl Zafara Plushie", "Faerie Harris Plushie", "Marshmallow Grundo Plushie", "Faerie Ixi Plushie", "Illusen Fan Grarrl Plushie", "Royal Evil Fuzzle","Darigan Lenny Plushie", "Desert Meerca Plushie", "Robo Grarrl Plushie", "Mutant Chia Plushie", "Droolik Plushie", "Mutant Buzz Plushie", "Darkest Faerie Plushie", "Lord Kass Plushie", "Illusen Fan Blumaroo Plushie", "Kau Defender of Neopia Plushie", "Royal Boy Kougra Plushie", "Green Frogarott Plushie", "Hagan Plushie", "Greedy Kadoatie Plushie", "Royal Girl Usul Plushie", "Orange Negg Plushie", "Collectors Edition Quiguki Boy Plushie", "Handcrafted Fyora Plushie", "Red Draik Plushie", "Zombom Plushie", "Mipsy Plushie", "Valin Plushie", "Camouflage Wocky Plushie", "Maraquan Anubis Plushie", "Desert Wocky Plushie", "Zombie Slorg Plushie", "Starry Fuzzle", "Evil Twin Blue Aisha Plushie", "Green Draik Plushie", "Plushie Quiggle Plushie", "Spotted Lupe Plushie", "Grimtooth Plushie", "Knitted Poogle Plushie"],
    "yellow");

    //    GREEN words. Black background, green text.

    defwords(["Darigan Acara Plushie", "Darigan Eyrie Plushie", "Disco Bruce Plushie", "Faerie Draik Plushie", "Shop Wizard Plushie", "Grey Flotsam Plushie", "Magical Yellow Flotsam Plushie", "Magical Starry Lupe Plushie", "Tormund Plushie", "Grey Kacheek Plushie", "Starry Uni Plushie", "Un-Valentines Skeith Plushie", "Armin Plushie", "Darigan Lupe Plushie", "Electric Evil Fuzzle", "Mutant Kiko Plushie", "Desert Aisha Plushie", "Baby Uni Plushie", "Orange Draik Plushie", "Baby Cybunny Plushie", "Plushie Poogle Plushie", "Denethrir Plushie", "Faerie Shoyru Plushie", "Mazzew Plushie", "Rainbow Scorchio Plushie", "Blue Draik Plushie", "Magical Pirate Krawk Plushie", "Mutant Krawk Plushie", "Angel Chia Plushie", "Faerie Kougra Plushie", "Grey Peophin Plushie", "Asparagus Chia Plushie", "Mutant Kougra Plushie", "Baby Xweetok Plushie", "Rainbow Korbat Plushie", "Zafara Double Agent Plushie", "Jhudora Valentine Plushie", "Rainbow Fuzzle", "Illusen Plushie", "Magical Red Kyrii Plushie", "Desert Grarrl Plushie", "Granite Dervish Plushie", "Kiko Cadet Plushie", "Robot Kau Plushie", "Golden Bori Plushie", "Faerie Uni Plushie", "Grey Negg Plushie", "Grey Wocky Plushie", "Magical Red Buzz Plushie", "Maraquan Ixi Plushie", "Halloween Poogle Plushie", "Drakonid Plushie", "Roberta Plushie", "Faerie Meerca Plushie", "Evil Twin Yellow Chia Plushie", "Glyme Plushie", "Magical Red Flotsam Plushie", "Giant Jeran Plushie", "Pink Draik Plushie", "Candy Gelert Plushie", "Starry Koi Plushie", "Edna Plushie", "Plushie Wocky Plushie", "Doctor Plushie", "Black Bearog Plushie", "Tylix Plushie", "Christmas Bruce Plushie", "Handcrafted Kanrik Plushie", "Electric Fuzzle", "Eye Candy Plushie", "Halloween Mynci Plushie", "Magical Green Kyrii Plushie", "Plains Lupe Neoquest Plushie", "Purple Mynci Plushie", "Young Sophie Plushie", "Kanrik Plushie", "Knitted Chia Plushie", "Rock Golem Neoquest Plushie", "Desert Elephante Plushie", "Agate Dervish Plushie", "Yellow Draik Plushie", "Quiguki Girl Plushie", "Mutant Usul Plushie", "Anshu Plushie", "Angel Kiko Plushie", "MSPP Plushie", "Faerie Slorg Plushie", "Jake Plushie", "Royal Girl Kyrii Plushie", "Faerie Kacheek Plushie", "Halloween Tonu Plushie", "Royal Boy Bruce Plushie", "Desert Ixi Plushie", "Baby Peophin Plushie", "Krawken Plushie", "Strawberry JubJub Plushie", "Halloween Nimmo Plushie", "White Skeith Plushie", "Grey Lupe Neoquest Plushie", "Striped Lenny Plushie", "The Masked Intruder Plushie", "Striped Korbat Plushie", "Fire JubJub Plushie", "Rainbow Ruki Plushie", "Mutant Elephante Plushie", "Scamander Plushie", "Darigan Flotsam Plushie", "Halloween Moehog Plushie", "Masila Plushie", "Baby Techo Plushie", "Giant Moehog Plushie", "Galem Plushie", "Darigan Krawk Plushie", "Rohane Plushie", "Pink Blumaroo Plushie", "Cloud Kacheek Plushie", "Spotted Uni Plushie", "Malkus Vile Plushie", "Shadow Yurble Plushie", "Mumbo Pango Plushie", "Faerie Bruce Plushie", "Faerie Xweetok Plushie", "Jhudora Plushie", "Darigan Gelert Plushie", "Pirate Moehog Plushie", "Manufacturing Error Faerie Plushie", "Scorchio Auctioneer Plushie", "Rainbow Wocky Plushie", "Royal Boy Ixi Plushie", "Magical Yellow Kyrii Plushie", "Magical Blue Kyrii Plushie", "Ghost Ixi Plushie", "Spider Grundo Plushie"],
    "green");

        //    BLUE words. Black background, blue text.

    defwords(["Fish Negg Plushie", "Spotted Gelert Plushie", "Tax Beast Plushie", "Mutant Korbat Plushie", "Magical Rainbow Cybunny Plushie", "Rainbow Evil Fuzzle", "Rainbow Uni Plushie", "Wrawk the Merciless Plushie", "Cloud Draik Plushie", "Rikti Plushie", "Magical Ghost Marshmallows Plushie", "Magical Green Tonu Plushie", "Magical Yellow Tonu Plushie", "Fire Eyrie Plushie", "Magical Blue Krawk Plushie", "Magical Red Cybunny Plushie", "Sidney Plushie", "Grey Mynci Plushie", "Halloween JubJub Plushie", "Magical Blue Cybunny Plushie", "Magical Yellow Cybunny Plushie", "Archmagus of Roo Plushie", "Bowe Plushie", "Desert Lupe Plushie", "Electro Lizard Plushie", "Fire Lizard Plushie", "Ghost Evil Fuzzle", "Ghost Fuzzle", "Guardian of Fire Magic Plushie", "Hannah Plushie", "Jahbal Plushie", "King Skarl Plushie", "Magical Cloud Lenny Plushie", "Magical Green Koi Plushie", "Magical Green Yurble Plushie", "Magical Purple Blumaroo Plushie", "Magical Red Koi Plushie", "Mutant Shoyru Plushie", "Razul Plushie", "Reject Gelert Plushie", "Shock Lizard Plushie", "Magical Red Krawk Plushie", "Dusk Kougra Plushie", "Magical Blue Shoyru Plushie", "Faerie Korbat Plushie", "Leirobas Plushie", "Starry Draik Plushie", "Gloom Kougra Plushie", "Inferno Lizard Plushie", "Magical Green Kiko Plushie", "Magical Red Lenny Plushie", "Magical Red Tonu Plushie", "Magical Yellow Yurble Plushie", "Melatite Dervish Plushie", "Reject Blue Acara Plushie", "Tyrannian Techo Plushie", "Magical Spotted Blumaroo Plushie", "Magical Blue Kacheek Plushie", "Magical Blue Kiko Plushie", "Magical Blue Nimmo Plushie", "Magical Purple Zafara Plushie", "Magical Red Yurble Plushie", "Magical Yellow Nimmo Plushie", "Neoquest Gatekeeper Plushie", "Pomanna Plushie", "Magical Green Wocky Plushie", "Chaos Giant Plushie", "Chrysolite Dervish Plushie", "Halloween Draik Plushie", "Lazulite Dervish Plushie", "Lightning Lizard Plushie", "Magical Cloud Gelert Plushie", "Magical Desert Krawk Plushie", "Magical Green Elephante Toy", "Magical Red Grarrl Plushie", "Magical Red Wocky Plushie", "Speckled Nimmo Plushie", "Steel Golem Neoquest Plushie", "Baby Bruce Plushie", "Lightning Giant Plushie", "Magical Green Flotsam Plushie", "Magical Yellow Wocky Plushie", "Plushie Ixi Plushie", "Magical Red Usul Plushie", "Faerie Nimmo Plushie", "Magical Blue Yurble Plushie", "Mist Kougra Plushie", "Thunder Lizard Plushie", "Reject Yellow Acara Plushie", "Desert Cobrall Plushie", "Magical Red Gelert Plushie", "Rainbow Grundo Plushie", "Faerie Lupe Plushie", "Magical Electric Lupe Plushie", "Magical Starry Kau Plushie", "Magical Silver Kougra Plushie", "Insane Evil Fuzzle", "Sophie Plushie", "Magical MSP Poogle Plushie", "Bat Thing Plushie", "Halloween Chia Plushie", "Taelia Plushie", "Rainbow JubJub Plushie", "Magical Cloud Lupe Plushie", "Magical Fire Lupe Plushie", "White Draik Plushie", "Reject Green Acara Plushie", "Magical Green Cybunny Plushie", "NeoQuest Hero Plushie"],
    "blue");

    //    Add one or more words to the dictionary with a specified class

    function defwords(words, which_class) {
    for (var i = 0; i < words.length; i++) {
        var w = words[i].replace(/^=/, "");
        patterns.push(new RegExp("([^a-zA-Z])(" + w + ")([^a-zA-Z])",
        words[i].match(/^=/) ? "g" : "gi"));
        classes.push(which_class);
    }
    }

    //    Quote HTML metacharacters in body text

    function quoteHTML(s) {
    s = s.replace(/&/g, "&amp;");
    s = s.replace(/</g, "&lt;");
    s = s.replace(/>/g, "&gt;");
    return s;
    }

    //    Add one or more CSS style rules to the document

    function addGlobalStyle(css) {
    var head, style;
    head = document.getElementsByTagName('head')[0];
    if (!head) {
        return;
    }
    style = document.createElement('style');
    style.type = 'text/css';
    style.innerHTML = css;
    head.appendChild(style);
    }

    //    Apply highlighting replacements to a text sequence

    var curpat;             // Hidden argument to repmatch()
    var changes;            // Number of changes made by repmatch()

    function repmatch(matched, before, word, after) {
    changes++;
    return before + '<span class="' + classes[curpat] + '">' + word + '</span>' + after;
    }

    function highlight(s) {
    s = " " + s;
    for (curpat = 0; curpat < patterns.length; curpat++) {
        s = s.replace(patterns[curpat],
            repmatch);
    }
    return s.substring(1);
    }

    //    We only modify HTML/XHTML documents
    if (document.contentType &&
        (!(document.contentType.match(/html/i)))) {
        return;
    }

    // Highlight words in body copy

    var textnodes = document.evaluate("//body//text()", document, null,
        XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE, null);

    for (var i = 0; i < textnodes.snapshotLength; i++) {
    var node = textnodes.snapshotItem(i);
    /* Test whether this text node appears within a
       <style>, <script>, or <textarea> container.
       If so, it is not actual body text and must
       be left alone to avoid wrecking the page. */
    if (node.parentNode.tagName != "STYLE" &&
        node.parentNode.tagName != "TEXTAREA" &&
        node.parentNode.tagName != "SCRIPT") {
        /* Many documents have large numbers of empty text nodes.
           By testing for them, we avoid running all of our
           regular expressions over a target which they can't
           possibly match. */
        if (!(node.data.match(/^\s*$/))) {
        var s = " " + node.data + " ";
        changes = 0;
        var d = highlight(quoteHTML(s));
        if (changes > 0) {
            var rep = document.createElement("span");
            rep.innerHTML = d.substring(1, d.length - 1);
            node.parentNode.replaceChild(rep, node);
        }
        }
    }
    }

})();

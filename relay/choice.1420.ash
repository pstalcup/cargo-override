record pocket {
    string description;
    item[int] items;
    effect[int] effects;
    string[int] icons;
};

pocket[int] build_pockets() {
    pocket[int] pockets;
    {
        pocket p;
        p.description = "Gain 250 Myst Substats";
        p.icons = { "partyhat.gif" };
        pockets[37] = p;
    }
    {
        pocket p;
        p.description = "Fight Dairy Goat";
        p.items = { $item[goat cheese] };
        pockets[47] = p;
    }
    {
        pocket p;
        p.description = "Very Attractive (20)";
        p.effects = { $effect[Very Attractive] };
        pockets[53] = p; 
    }
    {
        pocket p;
        p.description = "Fight Knob Goblin Elite Guardsman";
        p.icons = { "elitehelm.gif" };
        pockets[136] = p; 
    }
    {
        pocket p;
        p.description = "Gain 250 Muscle Substats";
        p.icons = { "barbell.gif" };
        pockets[161] = p; 
    }
    {
        // GOO ONLY
        pocket p;
        p.description = "Yeg's Motel Hand Soap";
        p.items = { $item[Yeg's Motel hand soap] };
        pockets[177] = p; 
    }
    {
        pocket p;
        p.description = "Fight a Modern Zmobie";
        p.icons = { "evilometer.gif" };
    }
    {
        pocket p;
        p.description = "Ode to Booze (20)"; 
        p.effects = { $effect[Ode to Booze] };
        pockets[242] = p;
    }
    {
        pocket p;
        p.description = "Frosty Hand (20)";
        p.effects = { $effect[Frosty Hand] };
        pockets[256] = p;
    }
    {
        pocket p;
        p.description = "Gain 250 Moxie Substats";
        p.icons = { "wink.gif" };
        pockets[277] = p; 
    }
    {
        pocket p;
        p.description = "Fight a Knob Goblin Harem Girl";
        p.icons = { "veil.gif" };
        pockets[299] = p; 
    }
    {
        pocket p;
        p.description = "Fight a Camel's Toe";
        p.items = { $item[star], $item[line] };
        pockets[317] = p; 
    }
    {
        pocket p;
        p.description = "Night Vision (50)";
        p.effects = { $effect[Night Vision] };
        pockets[339] = p; 
    }
    {
        pocket p;
        p.description = "Filthworm Drone Stench (5)";
        p.effects = { $effect[Filthworm Drone Stench] };
        pockets[343] = p; 
    }
    {
        pocket p;
        p.description = "Barely Visible (20)";
        p.effects = { $effect[Barely Visible] };
        pockets[347] = p;
    }
    {
        pocket p;
        p.description = "Fight a Skinflute";
        p.items = { $item[star], $item[line] };
        pockets[383] = p;
    }
    {
        // GOO ONLY
        pocket p;
        p.description = "Gain a Tangerine";
        p.items = { $item[tangerine] };
        pockets[396] = p; 
    }
    {
        pocket p;
        p.description = "Fight a Booze Giant";
        p.icons = { "bottle.gif" };
        pockets[490] = p; 
    }
    {
        pocket p;
        p.description = "Gain a bell to fight Astrologer of Shub-Jigguwatt";
        p.items = { $item[greasy desk bell], $item[star chart] };
        pockets[533] = p; 
    }
    {
        pocket p;
        p.description = "Fight a Mountain Man";
        p.icons = { "core.gif" };
        pockets[565] = p;
    }
    {
        pocket p;
        p.description = "Fight a Green Ops Soldier";
        p.items = { $item[green smoke bomb] };
    }
    {
        // GOO ONLY
        pocket p;
        p.description = "Medieval Mage Mayhem (20)"; 
        p.effects = { $effect[Medieval Mage Mayhem] };
        pockets[617] = p; 
    }
    {
        pocket p;
        p.description = "Fight a Smut Orc Pervert";
        p.items = { $item[smut orc keepsake box] };
        pockets[666] = p; 
    }
    return pockets;
}

string build_pocket_row(int pocket_number, pocket current_pocket, boolean enabled) {
    string pocket_number_str = to_string(pocket_number); 
    string disabled_str = "style=\"width: 4em\" ";
    if(!enabled) {
        disabled_str = "disabled style=\"cursor: not-allowed; color: gray; width: 4em\"";
    }
    string button_form = "<form method=\"post\" action=\"choice.php\" style=\"display: inline\">" +
    "  <input type=\"hidden\" name=\"whichchoice\" value=\"1420\">" + 
    "  <input type=\"hidden\" name=\"pwd\" value=\"" + my_hash() + "\">" +
    "  <input type=\"hidden\" name=\"option\" value=\"1\">" +
    "  <input type=\"hidden\" name=\"pocket\" value=\"" + pocket_number_str + "\">" +
    "  <input type=\"submit\" value=\"#" + pocket_number_str + "\" class=\"button\" " + disabled_str + ">" + 
    "</form>";

    string items_str = "";
    string effects_str = "";
    string icons_str = ""; 

    foreach i in current_pocket.items {
        item pocket_item = current_pocket.items[i]; 
        items_str = items_str + "<img src=\"images/itemimages/" + pocket_item.image +"\" class=\"hand item\" data-descid=\"" + pocket_item.descid + "\">";
    }
    foreach i in current_pocket.effects {
        effect pocket_effect = current_pocket.effects[i]; 
        effects_str = items_str + "<img src=\"images/itemimages/" + pocket_effect.image +"\" class=\"hand effect\" data-descid=\"" + pocket_effect.descid + "\">";
    }
    foreach i in current_pocket.icons {
        string pocket_icon = current_pocket.icons[i]; 
        effects_str = items_str + "<img src=\"images/itemimages/" + pocket_icon +"\" class=\"icon\">";
    }

    return "<tr valign=\"top\"><td>" + button_form + "</td><td>" + current_pocket.description + "</td><td>" + items_str + effects_str + "</td></tr>";
}

string build_effect_table(buffer page_text) {
    string table_head = "<table><thead><tr><td style=\"color: white;\" align=\"center\" bgcolor=\"blue\" colspan=3><b>The Choicest Pockets</b></td></tr></thead>";
    string table_foot = "</table>";

    string table_contents = "";
    pocket[int] pockets = build_pockets(); 

    foreach i in pockets {
        matcher used_matcher = create_matcher("#" + to_string(i), page_text); 
        table_contents = table_contents + build_pocket_row(i, pockets[i], find(used_matcher));
    }

    return table_head + table_contents + table_foot;
}

string javascript() {
    return "<script>" +
           "  jQuery(function(){" + 
           "    jQuery('.effect').click(function(e){eff(jQuery(e.target).data('descid'))});" + 
           "    jQuery('.item').click(function(e){item(jQuery(e.target).data('descid'))});" +
           "  });" +
           "</script>";
}

void main() {
	buffer page_text = visit_url();
    buffer out_page;
    string match_text = "There appear to be 666 pockets on these shorts";

    matcher text_matcher = create_matcher(match_text, page_text);
    string final_page_text = javascript() + build_effect_table(page_text) + match_text;

    string out_text = replace_first(text_matcher, final_page_text);

    out_page.append(out_text);
    write(out_page);
}
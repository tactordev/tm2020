const string PLUGIN_NAME = " Map Battle";

void RenderMenu()
{   
    if (UI::BeginMenu(Icons::HourglassEnd + PLUGIN_NAME))
    {       
        if (UI::MenuItem(Icons::PlayCircle + " Join Room"))
        {   
            Join::Toggle(); 
        } else if (UI::MenuItem(Icons::PlusCircle + " Create Room"))
        {   
            Create::Toggle(); 
        } else if (UI::MenuItem(Icons::Cog + " Manage Room"))
        {   
            Manage::Toggle(); 
        } else if (UI::MenuItem(Icons::Retweet + " Load Random Map"))
        {   
            MapLoader::LoadTestingMap();
        } else if (UI::BeginMenu(Icons::Cogs + " Socket Testing"))
        {
            if (UI::MenuItem(Icons::PlusCircle + " Subscribe"))
            {
                startnew(Subscriber::Subscribe, "TestPlayerId");
            } else if (UI::MenuItem(Icons::TimesCircle + " Unsubscribe"))
            {
                Subscriber::Unsubscribe("TestPlayerId");
            } else if (UI::MenuItem(Icons::ArrowCircleOUp + " Send Update"))
            {
                Subscriber::Emit("TestPlayerId", "Message test.");
            }
            UI::EndMenu();
        }
        UI::EndMenu();
    }
}


void Render()
{
    Join::Render();
    Create::Render();
    Manage::Render();
}
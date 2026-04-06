

namespace Manage
{
    bool show = false;

    void Render()
    {
        if (show) 
        {
            UI::Begin("Manage Room");
            UI::BeginTabBar("ManageTabs");
            if (UI::BeginTabItem("Players"))
            {
                UI::Text("This is the players tab.");
                UI::EndTabItem();
            }
            if (UI::BeginTabItem("Settings"))
            {
                UI::Text("This is the settings tab.");
                UI::EndTabItem();
            }
            UI::EndTabBar();
            UI::End();
        }
    }

    void Toggle()
    {
        show = !show;
    }
}
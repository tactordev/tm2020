

namespace Join
{
    bool show = false;

    void Render()
    {
        if (show) 
        {
            UI::Begin("Join Room");
            UI::Text("This is the join room window.");
            if (UI::Button("Close"))
            {
                show = false;
            }
            UI::End();
        }
    }

    void Toggle()
    {
        show = !show;
    }
}
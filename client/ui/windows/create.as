

namespace Create
{
    bool show = false;

    void Render()
    {
        if (show) 
        {
            UI::Begin("Create Room");
            UI::Text("This is the create room window.");
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
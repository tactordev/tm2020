

namespace Toasts
{
    void Warn(const string &in message)
    {
        UI::ShowNotification("Warning", message, 2000);
    }
}
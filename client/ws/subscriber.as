bool roomConnected = false;

namespace Subscriber
{
    Net::Socket@ g_Socket;

    void Main()
    {
        while (true)
        {
            if (roomConnected && g_Socket !is null && g_Socket.IsReady() && !g_Socket.IsHungUp())
            {
                if (g_Socket.Available() > 0)
                {
                    string message = g_Socket.ReadRaw(g_Socket.Available());
                    Update("Server", message);
                }

               
            }

            if (g_Socket !is null && g_Socket.IsHungUp())
            {
                print("Connection was closed.");
                UI::ShowNotification("Connection Closed", "The connection to the server was closed.", 2000);
                @g_Socket = null;
                roomConnected = false;
            }

            
            yield();
        }
    }

    void Subscribe(const string &in playerId)
    {
        if (roomConnected) {
            UI::ShowNotification("Already Subscribed", "You are already subscribed to a player.", 2000);
            return;
        }
        @g_Socket = Net::Socket();
        bool started = g_Socket.Connect("https://mapbattle-tcp-socket.onrender.com/", 4040);
        if (!started) {
            print("Connection start failed.");
            UI::ShowNotification("Subscribe Failed", "Could not start TCP connection.", 2000);
            return;
        }

        print("Connecting...");
        while(!g_Socket.IsReady() && !g_Socket.IsHungUp()) { yield(); }

        if (g_Socket.IsHungUp()) {
            print("Connection was closed before becoming ready.");
            UI::ShowNotification("Subscribe Failed", "TCP connection closed.", 2000);
            @g_Socket = null;
            return;
        }

        print("Ready.");
        g_Socket.WriteLine(playerId);
        UI::ShowNotification("Subscribed", "You have subscribed to player " + playerId, 2000);
        roomConnected = true;

    }

    void Unsubscribe(const string &in playerId)
    {
        if (g_Socket !is null) {
            g_Socket.Close();
            @g_Socket = null;
        }
        UI::ShowNotification("Unsubscribed", "You have unsubscribed from player " + playerId, 2000);
    }

    void Update(const string &in playerId, const string &in message)
    {
        print("Received update from " + playerId + ": " + message);
        UI::ShowNotification("Update from " + playerId, message, 2000);
    }

    void Emit(const string &in playerId, const string &in message)
    {
        if (g_Socket !is null && g_Socket.IsReady()) {
            g_Socket.WriteLine(message);
            print("Sent update from " + playerId + ": " + message);
        } else {
            print("Cannot send update, socket not ready.");
            UI::ShowNotification("Emit Failed", "Cannot send update, socket not ready.", 2000);
        }
    }
}
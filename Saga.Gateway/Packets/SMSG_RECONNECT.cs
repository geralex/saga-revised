using Saga.Network.Packets;

namespace Saga.Shared.PacketLib.Gateway
{
    /// <summary>
    /// Server → Client packet for AGCT_RECONNECT (Ctrl=2, Cmd=8).
    /// Sent when the player returns from game world to character select.
    /// RetCode 0 = success, client switches connection to login framing.
    /// </summary>
    public class SMSG_RECONNECT : Packet
    {
        public SMSG_RECONNECT()
        {
            this.data = new byte[1];
            this.Id = 0x0208;
        }

        public byte Result
        {
            set { this.data[0] = value; }
        }
    }
}

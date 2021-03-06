using Saga.Network.Packets;
using System;

namespace Saga.Packets
{
    /// <summary>
    ///
    /// </summary>
    /// <remarks>
    /// This packet is sent to the player when he or she wants to make
    /// a screenshot of the game.
    /// </remarks>
    /// <id>
    /// 1101
    /// </id>
    internal class CMSG_SELECTCHANNEL : RelayPacket
    {
        public CMSG_SELECTCHANNEL()
        {
        }

        public byte Channel
        {
            get
            {
                return this.data[0];
            }
        }

        #region Conversions

        public static explicit operator CMSG_SELECTCHANNEL(byte[] p)
        {
            /*
            // Creates a new byte with the length of data
            // plus 4. The first size bytes are used like
            // [PacketSize][PacketId][PacketBody]
            //
            // Where Packet Size equals the length of the
            // Packet body, Packet Identifier, Packet Size
            // Container.
            */

            CMSG_SELECTCHANNEL pkt = new CMSG_SELECTCHANNEL();
            pkt.data = new byte[p.Length - 14];
            pkt.session = BitConverter.ToUInt32(p, 2);
            Array.Copy(p, 6, pkt.cmd, 0, 2);
            Array.Copy(p, 12, pkt.id, 0, 2);
            Array.Copy(p, 14, pkt.data, 0, p.Length - 14);
            return pkt;
        }

        #endregion Conversions
    }
}
using Saga.Network.Packets;
using System;

namespace Saga.Packets
{
    /// <summary>
    ///
    /// </summary>
    /// <remarks>
    /// This packet is sent by the client when he/she wants to register
    /// an new item on the market.
    /// </remarks>
    /// <id>
    /// 0F04
    /// </id>
    internal class CMSG_MARKETREGISTER : RelayPacket
    {
        public CMSG_MARKETREGISTER()
        {
            this.data = new byte[7];
        }

        public byte Index
        {
            get
            {
                return this.data[0];
            }
        }

        public byte Count
        {
            get
            {
                return this.data[1];
            }
        }

        public uint Price
        {
            get
            {
                return BitConverter.ToUInt32(this.data, 2);
            }
        }

        public byte Days
        {
            get
            {
                return this.data[6];
            }
        }

        #region Conversions

        public static explicit operator CMSG_MARKETREGISTER(byte[] p)
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

            CMSG_MARKETREGISTER pkt = new CMSG_MARKETREGISTER();
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
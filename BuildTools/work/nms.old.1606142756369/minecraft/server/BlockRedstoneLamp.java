package net.minecraft.server;

import java.util.Random;
import javax.annotation.Nullable;

import org.bukkit.craftbukkit.event.CraftEventFactory; // CraftBukkit

public class BlockRedstoneLamp extends Block {

    public static final BlockStateBoolean a = BlockRedstoneTorch.LIT;

    public BlockRedstoneLamp(BlockBase.Info blockbase_info) {
        super(blockbase_info);
        this.j((IBlockData) this.getBlockData().set(BlockRedstoneLamp.a, false));
    }

    @Nullable
    @Override
    public IBlockData getPlacedState(BlockActionContext blockactioncontext) {
        return (IBlockData) this.getBlockData().set(BlockRedstoneLamp.a, blockactioncontext.getWorld().isBlockIndirectlyPowered(blockactioncontext.getClickPosition()));
    }

    @Override
    public void doPhysics(IBlockData iblockdata, World world, BlockPosition blockposition, Block block, BlockPosition blockposition1, boolean flag) {
        if (!world.isClientSide) {
            boolean flag1 = (Boolean) iblockdata.get(BlockRedstoneLamp.a);

            if (flag1 != world.isBlockIndirectlyPowered(blockposition)) {
                if (flag1) {
                    world.getBlockTickList().a(blockposition, this, 4);
                } else {
                    // CraftBukkit start
                    if (CraftEventFactory.callRedstoneChange(world, blockposition, 0, 15).getNewCurrent() != 15) {
                        return;
                    }
                    // CraftBukkit end
                    world.setTypeAndData(blockposition, (IBlockData) iblockdata.a((IBlockState) BlockRedstoneLamp.a), 2);
                }
            }

        }
    }

    @Override
    public void tickAlways(IBlockData iblockdata, WorldServer worldserver, BlockPosition blockposition, Random random) {
        if ((Boolean) iblockdata.get(BlockRedstoneLamp.a) && !worldserver.isBlockIndirectlyPowered(blockposition)) {
            // CraftBukkit start
            if (CraftEventFactory.callRedstoneChange(worldserver, blockposition, 15, 0).getNewCurrent() != 0) {
                return;
            }
            // CraftBukkit end
            worldserver.setTypeAndData(blockposition, (IBlockData) iblockdata.a((IBlockState) BlockRedstoneLamp.a), 2);
        }

    }

    @Override
    protected void a(BlockStateList.a<Block, IBlockData> blockstatelist_a) {
        blockstatelist_a.a(BlockRedstoneLamp.a);
    }
}

enum cell_flags_t{
    Cell_Fixed      =0x1,
    Cell_Insulator  =0x2,
    Cell_Above      =0x4,
    Cell_Below      =0x8,
    Cell_Left       =0x10,
    Cell_Right      =0x20,
};

__kernel void kernel_xy(const float inner, const float outer, __global const float *world_state, __global  const uint *world_properties, __global float *buffer)
{
    uint x=get_global_id(0);
    uint y=get_global_id(1);
    uint w=get_global_size(0);

    unsigned index=y*w + x;
            
    if((world_properties[index] & Cell_Fixed) || (world_properties[index] & Cell_Insulator)){
        // Do nothing, this cell never changes (e.g. a boundary, or an interior fixed-value heat-source)
        buffer[index]=world_state[index];
    }else{
        float contrib=inner;
        float acc=inner*world_state[index];
        
        // Cell above
        if(! (world_properties[index] & Cell_Above)) {
            contrib += outer;
            acc += outer * world_state[index-w];
        }
        
        // Cell below
        if(! (world_properties[index] & Cell_Below)) {
            contrib += outer;
            acc += outer * world_state[index+w];
        }
        
        // Cell left
        if(! (world_properties[index] & Cell_Left)) {
            contrib += outer;
            acc += outer * world_state[index-1];
        }
        
        // Cell right
        if(! (world_properties[index] & Cell_Right)) {
            contrib += outer;
            acc += outer * world_state[index+1];
        }
        
        // Scale the accumulate value by the number of places contributing to it
        float res=acc/contrib;
        // Then clamp to the range [0,1]
        res = min(1.0f, max(0.0f, res));
        buffer[index] = res;
    }
};
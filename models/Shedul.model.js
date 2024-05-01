import mongoose from 'mongoose';

const ShedulSchema = new mongoose.Schema(
  {
    currentId: {
        type: String,
        required: true,
        
      },
    name: {
        type: String,
        required: true,
        
      },
    Email: {
        type: String,
        required: true,
        
      },
   
    phone: {
      type: Number,
      required: true,
      
    },
    date: {
        type: String,
        required: true,
     
      },
      time: {
        type: String,
        required: true,
     
      },
   
   
   
  },
  { timestamps: true }
);

const Shedul = mongoose.model('Shedul', ShedulSchema);

export default Shedul;
import express from 'express';
import { Schedulcreate,  allgetSchedul,  deleteSchedul,   getschedul,  signout, test,  updateschedul} from '../controllers/user.controller.js';
import { verifyToken } from '../utils/VerfiyUser.js';
const router = express.Router();


router.get('/test', test); 
router.post('/signout', signout);
router.post('/schcreate', Schedulcreate);
router.get('/schedul/:currentId', getschedul);
router.get('/schedull',verifyToken, allgetSchedul);
router.put( '/updatee/:schedulId', updateschedul);
router.delete('/deletee/:scheduId',  deleteSchedul);


export default router;
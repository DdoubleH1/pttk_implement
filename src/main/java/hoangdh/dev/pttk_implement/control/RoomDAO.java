package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.Room;

public class RoomDAO extends DAO {
    public RoomDAO() {
        super();
    }
    public void createRoom(Room room) {
        getSession().beginTransaction();
        getSession().persist(room);
        getSession().getTransaction().commit();
    }

    public Room getRoomById(int id) {
        getSession().beginTransaction();
        Room room = getSession().get(Room.class, id);
        getSession().getTransaction().commit();
        return room;
    }
}

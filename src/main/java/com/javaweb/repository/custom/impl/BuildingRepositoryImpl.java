package com.javaweb.repository.custom.impl;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.repository.custom.BuildingrepositoryCustom;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;
import java.util.stream.Collectors;

@Repository
@Primary
public class BuildingRepositoryImpl implements BuildingrepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    public static void joinTable(BuildingSearchBuilder buildingSearchBuilder, StringBuilder sql) {
        Long staffId = buildingSearchBuilder.getStaffId();
        if(staffId != null) {
            sql.append("INNER JOIN assignmentbuilding ab ON b.id = ab.buildingid ");
        }
    }
    public static void queryNormal(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where) {
        try {
            Field[] fields = BuildingSearchBuilder.class.getDeclaredFields();
            for(Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();
                if(!fieldName.equals("staffId") && !fieldName.equals("typeCode") &&
                        !fieldName.startsWith("area") && !fieldName.startsWith("rentPrice")) {
                    Object value = item.get(buildingSearchBuilder);
                    if(value != null) {
                        if(item.getType().getName().equals("java.lang.Long") ||  item.getType().getName().equals("java.lang.Integer")) {
                            where.append(" AND b." + fieldName + " = " + value + " ");
                        }
                        else if(item.getType().getName().equals("java.lang.String")) {
                            where.append(" AND b." + fieldName + " LIKE '%" + value + "%' ");
                        }
                    }
                }
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    public static void querySpecail(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where) {
        Long staffId = buildingSearchBuilder.getStaffId();
        if(staffId != null) {
            where.append(" AND ab.staffid = " + staffId + " ");
        }
        Long rentAreaTo = buildingSearchBuilder.getAreaTo();
        Long rentAreaFrom = buildingSearchBuilder.getAreaFrom();
        if(rentAreaTo != null || rentAreaFrom != null) {
            where.append(" AND EXISTS (SELECT * FROM rentarea r WHERE b.id = r.buildingid ");
            if(rentAreaFrom != null) {
                where.append(" AND r.value >= " + rentAreaFrom + " ");
            }
            if(rentAreaTo != null) {
                where.append(" AND r.value <= " + rentAreaTo + " ");
            }
            where.append(") ");
        }
        Long rentPriceTo = buildingSearchBuilder.getRentPriceTo();
        Long rentPriceFrom = buildingSearchBuilder.getRentPriceFrom();
        if(rentPriceTo != null || rentPriceFrom != null) {
            if(rentPriceFrom != null) {
                where.append(" AND b.rentprice >= " + rentPriceFrom + " ");
            }
            if(rentPriceTo != null) {
                where.append(" AND b.rentprice <= " + rentPriceTo + " ");
            }
        }
        List<String> typeCode = buildingSearchBuilder.getTypeCode();
        if(typeCode != null && typeCode.size() != 0) {
            where.append(" AND(");
            String sql = typeCode.stream().map(it -> "b.type like '%" + it + "%' ").collect(Collectors.joining(" OR "));
            where.append(sql);
            where.append(" ) ");
        }
    }
    private StringBuilder buildQueryFilter(BuildingSearchBuilder buildingSearchBuilder, Pageable pageable) {
        StringBuilder sql = new StringBuilder("SELECT b.* FROM building b ");
        joinTable(buildingSearchBuilder, sql);
        StringBuilder where = new StringBuilder("WHERE 1=1 ");
        queryNormal(buildingSearchBuilder, where);
        querySpecail(buildingSearchBuilder, where);
        where.append("GROUP BY b.id ");
        sql.append(where);
        return sql;
    }
    @Override
    public List<BuildingEntity> findBuildings(BuildingSearchBuilder buildingSearchBuilder, Pageable pageable) {
        StringBuilder sql = buildQueryFilter(buildingSearchBuilder, pageable);
        sql.append(" LIMIT ").append(pageable.getPageSize()).append("\n");
        sql.append(" OFFSET ").append(pageable.getOffset());
        Query query = entityManager.createNativeQuery(sql.toString(), BuildingEntity.class);
        return query.getResultList();
    }
    @Override
    public int countTotalItem(BuildingSearchBuilder buildingSearchBuilder, Pageable pageable) {
        StringBuilder sql = buildQueryFilter( buildingSearchBuilder, pageable);
        Query query = entityManager.createNativeQuery(sql.toString());
        return query.getResultList().size();
    }
}
